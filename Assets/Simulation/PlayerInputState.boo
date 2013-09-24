
# Stores the state of the input of a single player at a frame.
struct PlayerInputState:
	final HorizontalMovement as int
	final Drop as bool
	final RotateDirection as int

	def constructor(horizontalMovement as int, drop as bool, rotateDirection as int):
		self.HorizontalMovement = horizontalMovement
		self.Drop = drop
		self.RotateDirection = rotateDirection