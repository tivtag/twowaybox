
# Represents a single Player of the game
# There are always two of these active per game
class Player:
	Color as GameColor:
		get: return color

	Score as long:
		get: return score

	Blocks as PlayerBlocks:
		get: return blocks

	Movement as PlayerMovement:
		get: return movement

	def constructor(color as GameColor):
		self.color = color
		self.blocks = PlayerBlocks(self)
		self.movement = PlayerMovement(color)

	def Reset():
		score = 0
		blocks.Reset()
		movement.Reset()

	def IncreaseScoreForLineClear(lineClearCount as int):
		score += 10 * lineClearCount * lineClearCount * lineClearCount

	def IncreaseScoreForBlockDrop():
		score += 1

	def IncreaseScoreForSideClear():
		score += 1000

	def Update(inputState as PlayerInputState, oldInputState as PlayerInputState):
		movement.Update(inputState, oldInputState)

	private score as long

	private final movement as PlayerMovement
	private final blocks as PlayerBlocks
	private final color as GameColor