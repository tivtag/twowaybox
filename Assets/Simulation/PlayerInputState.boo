
# Stores the state of the input of a single player at a frame.
struct PlayerInputState:
	final HorizontalMovement as int
	final Drop as bool
	final RotateDirection as int

	def constructor(horizontalMovement as int, drop as bool, rotateDirection as int):
		self.HorizontalMovement = horizontalMovement
		self.Drop = drop
		self.RotateDirection = rotateDirection

	static def Merge(inputA as PlayerInputState, inputB as PlayerInputState):
		horizontalMovement = (inputB.HorizontalMovement if inputA.HorizontalMovement == 0 else inputA.HorizontalMovement)
		drop = inputA.Drop or inputB.Drop
		rotateDirection = (inputB.RotateDirection if inputA.RotateDirection == 0 else inputA.RotateDirection)
		
		return PlayerInputState(horizontalMovement, drop, rotateDirection)
