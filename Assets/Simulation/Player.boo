
# Represents a single Player of the game
# There are always two of these active per game
class Player:
	Color as GameColor:
		get: return color

	Score as PlayerScore:
		get: return score

	Blocks as PlayerBlocks:
		get: return blocks

	Movement as PlayerMovement:
		get: return movement

	Active as bool:
		get: return active
		set: active = value

	def constructor(color as GameColor):
		self.color = color
		self.blocks = PlayerBlocks(self)
		self.movement = PlayerMovement(color)

	def Reset():
		active = true
		score.Reset()
		blocks.Reset()
		movement.Reset()

	def Update(inputState as PlayerInputState, oldInputState as PlayerInputState):
		movement.Update(inputState, oldInputState)

	private active as bool = true

	private final score as PlayerScore = PlayerScore()
	private final movement as PlayerMovement
	private final blocks as PlayerBlocks
	private final color as GameColor