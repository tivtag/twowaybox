
# Represents a 3-D visualization of a Tetris Block that is placed parallel to a GameFieldView.
#
# The view is automatically destroyed when the block is destroyed.
class BlockView:
	Color as GameColor:
		get: return block.Color

	Cells as (Cube):
		get: return cubes

	CellSize as Point2:
		get: return block.Size

	def constructor(block as Block, parent as GameObject, cubes as (Cube), plane as GamePlane):
		self.block = block
		self.parent = parent
		self.cubes = cubes
		self.plane = plane
		
		HookEvents()

	private def HookEvents():
		self.block.Moved += OnBlockMoved
		self.block.RebuildRequired += OnBlockRebuildRequired
		self.block.Destroyed += OnBlockDestroyed

	private def UnhookEvents():
		self.block.Moved += OnBlockMoved
		self.block.RebuildRequired += OnBlockRebuildRequired
		self.block.Destroyed += OnBlockDestroyed

	def Destroy():
		UnhookEvents()
		
		for cube in cubes:
			cube.Destroy()
		GameObject.Destroy(parent)

	def WriteDebug():
		Debug.Log( "=====" )
		for cube in cubes:
			Debug.Log(cube.Position + " -> " + cube.CellPosition)
			Debug.Log(cube.Plane)
		Debug.Log( "=====" )

	private def OnBlockMoved(sender as object, e as MoveEventArgs):
		for cube in cubes:
			cube.MoveBy(e.Offset)

	private def OnBlockRebuildRequired(sender as object, e as EventArgs):
		index = 0
		for cell in block.Cells:
			position = plane.Center - plane.ToViewSpace(Vector3(cell.Position.x + 0.5 - SimulationConstants.HalfMatrixSize.x, 
																cell.Position.y + 0.5 - SimulationConstants.HalfMatrixSize.y,
																0.5))
			
			cubes[index++].SetPosition(cell.Position, position)

	private def OnBlockDestroyed(sender as object, e as EventArgs):
		Destroy()

	private final block as Block
	private final parent as GameObject
	private final cubes as (Cube)
	private final plane as GamePlane