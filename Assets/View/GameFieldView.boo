import UnityEngine

# A single simulation of 2D 'Tetris' in 3D-space.
# The field is made up of Cubes that are placed on a GamePlane.
class GameFieldView:
	Side as GameSide:
		get: return plane.Side

	Plane as GamePlane:
		get: return plane;

	Visible as bool:
		get: return visible
		set:
			if visible != value:
				for x in range(field.Size.x):
					for y in range(field.Size.y):
						cube = GetCube(Point2(x,y))
						if cube is not null:
							cube.Visible = value
				
				visible = value

	def constructor(field as GameField, plane as GamePlane, materialSelector as MaterialSelector):
		self.field = field
		self.plane = plane
		self.materialSelector = materialSelector
		
		field.CellChanged += OnCellChanged
		
		self.cubes = matrix(Cube, field.Size.x, field.Size.y)
		CreateCubes()

	private def CreateCubes():
		# The offset centers the cells around the center of the GamePlane
		offset = plane.ToViewSpace(Vector3((field.Size.x/2 - 0.5), (field.Size.y/2 - 0.5), -0.5))
		
		# Create each cell
		width = field.Size.x
		height = field.Size.y
		for x in range(width):
			for y in range(height):
				position = plane.Center + plane.ToViewSpace(Point2(x,y)) - offset
				
				cellPosition = Point2(width - x - 1, height - y - 1)
				color = field.GetCell(cellPosition)
				
				CreateCube(cellPosition, position, color);

	private def CreateCube(cellPosition as Point2, position as Vector3, color as GameColor):
		cube = Cube.CreateWall(plane, cellPosition, position, color, materialSelector)
		cubes[cellPosition.x, cellPosition.y] = cube

	private def GetCube(cellPosition as Point2):
		return cubes[cellPosition.x, cellPosition.y]

	def DrawGizmos():
		GizmoHelper.DrawPlane(plane)

	private def OnCellChanged(sender as object, e as CellChangedEventArgs):
		cell = e.Cell
		cube = GetCube(cell.Position)
		cube.Color = cell.Color
	
	private visible as bool = true
	private final field as GameField
	private final cubes as (Cube, 2)
	private final plane as GamePlane
	private final materialSelector as MaterialSelector