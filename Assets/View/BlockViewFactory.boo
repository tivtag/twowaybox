
# Responsible for building BlockViews based on Blocks,
# this includes all of the actual 3D-cubes.
class BlockViewFactory:
	def constructor(materialSelector as MaterialSelector):
		self.materialSelector = materialSelector

	def BuildBasedOn(block as Block, plane as GamePlane):
		parent = GameObject()
		parent.name = block.Template.Name
		cubes = array(Cube, block.CellCount)
		
		index = 0
		for cell in block.Cells:
			position = plane.Center - plane.ToViewSpace(Vector3(cell.Position.x + 0.5 - SimulationConstants.HalfMatrixSize.x, 
																cell.Position.y + 0.5 - SimulationConstants.HalfMatrixSize.y,
																0.5))
			
			cubes[index++] = Cube.CreateBlock(cell.Color, plane, cell.Position, position, parent.transform, materialSelector)
		
		return BlockView(block, parent, cubes, plane)

	private final materialSelector as MaterialSelector