
# Stores the state of the input of a single player at a frame.
struct PlayerInputState:
	final HorizontalMovement as int
	final Drop as bool
	final RotateDirection as int

	private def constructor(horizontalMovement as int, drop as bool, rotateDirection as int):
		self.HorizontalMovement = horizontalMovement
		self.Drop = drop
		self.RotateDirection = rotateDirection

	static def FromInput(playerColor as GameColor):
		drop               = Input.GetAxis(playerColor.ToString() + "-Drop") == 1
		horizontalMovement = Input.GetAxis(playerColor.ToString() + "-Horizontal")
		rotateDirection    = Input.GetAxis(playerColor.ToString() + "-Rotate")
		
		return PlayerInputState(horizontalMovement, drop, rotateDirection)