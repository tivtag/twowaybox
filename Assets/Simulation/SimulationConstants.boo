
# Holds various constants used in the simulation part of the game
class SimulationConstants:
	# The size of the gray filler around the game field (in cell space) 
	public static final FillerSize as Point2 = Point2(10, 0)
	public static final HalfFillerSize as Point2 = FillerSize / 2

	# The total size of the game field, including the world and the fillers (in cell space) 
	public static final MatrixSize as Point2 = Point2(20, 20)
	public static final HalfMatrixSize as Point2 = MatrixSize / 2

	# The size of the area in which the game is actually played (in cell space) 
	public static final WorldSize as Point2 = MatrixSize - FillerSize

	# The area of the game world
	public static final WorldStart as Point2 = SimulationConstants.HalfFillerSize
	public static final WorldEnd as Point2 = SimulationConstants.HalfFillerSize + SimulationConstants.WorldSize

	# The size of the top/bottom cover fields
	public static final CoverSize as Point2 = Point2(MatrixSize.x, MatrixSize.x)

	# Block rotation
	public static final RotationTime = 0.28

	# Left/Right movement
	public static HorizontalSingleStepMovementTime = 0.12
	public static final HorizontalSlideMovementTime = 0.06
	public static HorizontalSlideMovementStartTime = 0.15

	# Top/Bottom movement
	public static final VerticalSingleStepMovementTime = 1.1
	public static final VerticalDropTimeMultiplicator = 21

	# The time in seconds for which after a drop the next block won't start moving quickly
	public static final VerticalDropTimer as single = 0.1
	
	static def Configure():
		if PlatformHelper.IsTouch:
			HorizontalSingleStepMovementTime = 0.30
			HorizontalSlideMovementStartTime = 0.40
