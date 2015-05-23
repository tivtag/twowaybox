
# Holds various constants used in the visualisation of the game
class ViewConstants:
	public static CubeSize as single = 1.05
	public static HalfCubeSize as single = CubeSize / 2.0

	public static WorldSize as Vector2 = Vector2(CubeSize * SimulationConstants.MatrixSize.x, CubeSize * SimulationConstants.MatrixSize.y)
	public static HalfWorldSize as Vector2 = WorldSize / 2.0

	public static CameraOffsetFactor = 1

	public static CameraTransitionTime = 0.8