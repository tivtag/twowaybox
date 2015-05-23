import UnityEngine

# The main building block of GameField walls and Blocks; a single colored 3D-cube.
class Cube (Object):
	Color as GameColor:
		get:
			return color
		set:
			color = value
			cube.GetComponent[of Renderer]().material = materialSelector.GetMaterial(value)

	Position as Vector3:
		get: return transform.position

	CellPosition as Point2:
		get: return cellPosition

	Plane as GamePlane:
		get: return plane

	Visible as bool:
		get: return cube.GetComponent[of Renderer]().enabled
		set: cube.GetComponent[of Renderer]().enabled = value

	def constructor(materialSelector as MaterialSelector):
		self.materialSelector = materialSelector

	static def CreateWall(plane as GamePlane, cellPosition as Point2, position as Vector3, color as GameColor, materialSelector as MaterialSelector):
		wall = Cube(materialSelector)
		wall.Create("Wall " + plane.Side, cellPosition, color, plane, position)
		return wall

	static def CreateBlock(color as GameColor, plane as GamePlane, cellPosition as Point2, position as Vector3, parent as Transform, materialSelector as MaterialSelector):		
		block = Cube(materialSelector)
		block.Create("Block " + plane.Side, cellPosition, color, plane, position)
		block.cube.transform.parent = parent
		return block

	private def Create(name as string, cellPosition as Point2, color as GameColor, plane as GamePlane, position as Vector3):
		self.color = color
		self.plane = plane
		self.cube = Instantiate(materialSelector.GetPrefab(color), position, Quaternion.identity)
		self.cube.name = name + "_" + cellPosition.x + "/" + cellPosition.y
		self.transform = cube.GetComponent(typeof(Transform)) as Transform
		
		self.cellPosition = cellPosition

	def MoveBy(cellOffset as Point2):
		cellPosition += cellOffset
		transform.position -= plane.ToViewSpace(cellOffset)

	def SetPosition(cellPosition as Point2, position as Vector3):
		self.cellPosition = cellPosition
		self.transform.position = position

	def Destroy():
		GameObject.Destroy(cube)

	private color as GameColor
	private plane as GamePlane
	private cellPosition as Point2

	private cube as GameObject
	private transform as Transform

	private materialSelector as MaterialSelector