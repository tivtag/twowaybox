import System
import System.Collections.Generic


# Represents an instantiation of a BlockTemplate under a BlockRotation.
# E.g. a Tetromino that is positioned relative to a GameField
class Block:
	# Raised when the Block has moved by a specific amount in cell space
	event Moved as EventHandler[MoveEventArgs]

	# Raised when the Block has changed in such a huge way, that its visual representation should be completely rebuild
	event RebuildRequired as EventHandler

	# Raised when its time for the block to move on in life
	event Destroyed as EventHandler

	Color as GameColor:
		get: return color

	Cells as IEnumerable[Cell]:
		get:
			list = List[of Cell]()
			
			for cellOffset in rotation.CellOffsets:
				list.Add(Cell(position + cellOffset, color))
				
			return list

	CellCount as int:
		get: return rotation.CellCount

	Size as Point2:
		get: return template.Size

	Side as GameSide:
		get: return side

	Template as BlockTemplate:
		get: return template

	# Gets the vertical cell range that is currently covered by this Block	
	VerticalRange as Point2:
		get: 
			min = 1000
			max = -1
			
			for cell in Cells:
				min = System.Math.Min(min, cell.Position.y)
				max = System.Math.Max(max, cell.Position.y)
			
			return Point2(min, max)

	def constructor(template as BlockTemplate, color as GameColor, side as GameSide):
		self.template = template
		self.color = color
		self.side = side
		
		# Setup default rotation and position
		if color == GameColor.Black:
			Rotate(0)
			MoveBy(Point2(SimulationConstants.HalfMatrixSize.x - (Size.x/2) - 1, -1))
		else:
			Rotate(2)
			MoveBy(Point2(SimulationConstants.HalfMatrixSize.x - (Size.x/2) - 1, SimulationConstants.MatrixSize.y - Size.y + template.SpawnOffsetWhiteY))

	def MoveBy(offset as Point2):
		position += offset
		Moved(self, MoveEventArgs(offset)) unless Moved is null

	def Destroy():
		Destroyed(self, EventArgs.Empty) unless Destroyed is null

	def Rotate(direction as int):
		rotationIndex = template.GetRotationIndex(rotationIndex, direction)
		rotation = template.GetRotation(rotationIndex)
		
		NotifyRebuildRequired()

	private def NotifyRebuildRequired():
		RebuildRequired(self, EventArgs.Empty) unless RebuildRequired is null

	# The position of the anchor cell of the block relative to the game field
	private position as Point2

	private rotationIndex as int
	private rotation as BlockRotation

	private final template as BlockTemplate
	private final color as GameColor
	private final side as GameSide