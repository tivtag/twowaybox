
# Holds the next block template of a player; which is shared over all tetris games
class PlayerBlocks:
	def constructor(player as Player):
		self.player = player

	def SpawnNext(side as GameSide, blockFactory as BlockFactory):
		# Get next template
		template = self.nextBlockTemplate or blockFactory.GetRandomTemplate()
		self.nextBlockTemplate = blockFactory.GetRandomTemplate()

		# Create next block
		block = Block(template, player.Color, side)
		blockFactory.NotifySpawned(block)
		return block

	def Reset():
		nextBlockTemplate = null

	private nextBlockTemplate as BlockTemplate
	private final player as Player