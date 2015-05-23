
# Holds various constants used in the simulation part of the game
class SimulationConstants:
	# The size of the gray filler around the game field (in cell space) 
	public static FillerSize as Point2 = Point2(10, 0)
	public static HalfFillerSize as Point2 = FillerSize / 2

	# The total size of the game field, including the world and the fillers (in cell space) 
	public static MatrixSize as Point2 = Point2(20, 20)
	public static HalfMatrixSize as Point2 = MatrixSize / 2

	# The size of the area in which the game is actually played (in cell space) 
	public static WorldSize as Point2 = MatrixSize - FillerSize

	# The area of the game world
	public static WorldStart as Point2 = SimulationConstants.HalfFillerSize
	public static WorldEnd as Point2 = SimulationConstants.HalfFillerSize + SimulationConstants.WorldSize

	# The size of the top/bottom cover fields
	public static CoverSize as Point2 = Point2(MatrixSize.x, MatrixSize.x)

	# Block rotation
	public static RotationTime = 0.28

	# Left/Right movement
	public static HorizontalSingleStepMovementTime = 0.12
	public static HorizontalSlideMovementTime = 0.06
	public static HorizontalSlideMovementStartTime = 0.15

	# Top/Bottom movement
	public static VerticalSingleStepMovementTime = 1.1
	public static VerticalDropTimeMultiplicator = 21

	# The time in seconds for which after a drop the next block won't start moving quickly
	public static VerticalDropTimer as single = 0.1
	
	static def Configure():
		if PlatformHelper.IsTouch:
			HorizontalSingleStepMovementTime = 0.30
			HorizontalSlideMovementStartTime = 0.40
