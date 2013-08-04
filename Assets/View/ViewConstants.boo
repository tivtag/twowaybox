
# Holds various constants used in the visualisation of the game
class ViewConstants:
	public static final CubeSize as single = 1.05
	public static final HalfCubeSize as single = CubeSize / 2.0

	public static final WorldSize as Vector2 = Vector2(CubeSize * SimulationConstants.MatrixSize.x, CubeSize * SimulationConstants.MatrixSize.y)
	public static final HalfWorldSize as Vector2 = WorldSize / 2.0

	public static final CameraOffsetFactor = 1

	public static final CameraTransitionTime = 0.8