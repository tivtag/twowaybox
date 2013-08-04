
# Encapsulates the block movement state of a single player. 
class PlayerMovement:
	VerticalDirection as int:
		get: return verticalDirection

	VerticalAllowed as bool:
		get: return verticalTimer <= 0.0
	HorizontalAllowed as bool:
		get: return horizontalTimer <= 0.0
	RotationAllowed as bool:
		get: return rotationTimer <= 0.0

	def constructor(color as GameColor):
		verticalDirection = (1 if color == GameColor.Black else -1)
		Reset()

	def Update(inputState as PlayerInputState, oldInputState as PlayerInputState):
		UpdateVertical(inputState, oldInputState)
		UpdateHorizontal(inputState, oldInputState)
		UpdateRotation(inputState, oldInputState)

	private def UpdateVertical(inputState as PlayerInputState, oldInputState as PlayerInputState):		
		verticalTimer -= Time.deltaTime
		if verticalDropTimer > 0.0f:
			verticalDropTimer -= Time.deltaTime
		
		if not inputState.Drop:
			verticalDropTimer = 0.0
		
		if inputState.Drop and (verticalDropTimer <= 0.0):
			verticalTimer -= (Time.deltaTime * (SimulationConstants.VerticalDropTimeMultiplicator if inputState.Drop else 0))

	private def UpdateHorizontal(inputState as PlayerInputState, oldInputState as PlayerInputState):
		horizontalTimer -= Time.deltaTime
		
		# Reset timer on first press down to decrease felt input latency
		if oldInputState.HorizontalMovement == 0 and inputState.HorizontalMovement != 0:
			horizontalTimer = 0.0
			horizontalSlidingActive = false

	private def UpdateRotation(inputState as PlayerInputState, oldInputState as PlayerInputState):
		rotationTimer -= Time.deltaTime
		if oldInputState.RotateDirection == 0 and inputState.RotateDirection != 0:
			rotationTimer = 0.0

	def Reset():
		verticalDropTimer = 0.0
		ResetVerticalTimer()
		ResetHorizontalTimer()
		ResetRotationTimer()

	def ResetVerticalTimer():
		verticalTimer = SimulationConstants.VerticalSingleStepMovementTime

	def NotifyBlockSpawned():
		verticalDropTimer = SimulationConstants.VerticalDropTimer
		ResetVerticalTimer()

	def ResetHorizontalTimer():
		if horizontalSlidingActive:		
			horizontalTimer = SimulationConstants.HorizontalSlideMovementTime
		else:
			horizontalTimer = SimulationConstants.HorizontalSingleStepMovementTime
			horizontalSlidingActive = true

	def ResetRotationTimer():
		rotationTimer = SimulationConstants.RotationTime

	# Block rotation
	private rotationTimer as single

	# Left/Right-Movement. Sliding starts after first single-step movement, and is faster.
	private horizontalTimer as single
	private horizontalSlidingActive as bool
		
	# Up/Down-Movement. Blocks can only go into one verticalDirection per player
	private verticalDropTimer as single
	private verticalTimer as single
	private final verticalDirection as int