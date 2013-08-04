import System.Collections.Generic

# Represents the schema of a single rotation of a Tetromino
class BlockRotation:
	Size as Point2:
		get: return size

	CellOffsets as IEnumerable[Point2]:
		get: return cellOffsets

	CellCount as int:
		get: return cellOffsets.Length

	def constructor(cells as ((int))):
		self.cells = cells
		self.size = Point2(len(cells[0]), len(cells))
		
		list = List[of Point2]()
		
		for x in range(size.x):
			for y in range(size.y):
				position = Point2(x, y)
				if HasCell(position):
					list.Add(position)
		
		cellOffsets = list.ToArray()

	def HasCell(position as Point2):
		return cells[position.y][position.x] == 1

	private final size as Point2
	private final cells as ((int))
	private final cellOffsets as (Point2)