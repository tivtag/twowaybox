
# Simulates a single 2D-tetris game for a single player
class TetrisPlayerSimulation:
	GameLost as bool:
		get: return gameLost

	Color as GameColor:
		get: return player.Color

	def constructor(player as Player, tetris as TetrisSimulation, blockFactory as BlockFactory):
		self.player = player
		self.field = tetris.Field
		self.tetris = tetris
		self.blockFactory = blockFactory

	# Updates the simulation for the given player
	def Update():
		if gameLost:
			return
		
		inputState = PlayerInputState.FromInput(player.Color)
		player.Update(inputState, oldInputState)
		
		EnsureBlockSpawned()
		RotateBlock(inputState)
		MoveBlockHorizontal(inputState)	
		MoveBlockVertical()
		oldInputState = inputState

	# Resets the state of the simulation
	def Reset():
		if block != null:
			block.Destroy()
			block = null
		gameLost = false

	private def EnsureBlockSpawned():
		if block is null:
			block = player.Blocks.SpawnNext(tetris.Side, blockFactory)
			player.Movement.NotifyBlockSpawned()
			blockHadInitialCollisionTest = false

	# Rotate block
	private def RotateBlock(inputState as PlayerInputState):
		rotateDirection = inputState.RotateDirection
		if rotateDirection == 0 or not player.Movement.RotationAllowed:
			return
		
		block.Rotate(rotateDirection)
		if field.TestCollision(block, Point2()):
			block.Rotate(-rotateDirection) # undo rotation since it didn't work	
		
		player.Movement.ResetRotationTimer()

    # Move block left/right
	private def MoveBlockHorizontal(inputState as PlayerInputState):
		movement = inputState.HorizontalMovement
		if movement == 0 or not player.Movement.HorizontalAllowed:
			return
		
		offset = Point2(movement, 0)
		if not field.TestCollision(block, offset):
			block.MoveBy(offset) # undo movement
		
		player.Movement.ResetHorizontalTimer()

	# Move block up/down
	private def MoveBlockVertical():
		if not player.Movement.VerticalAllowed:
			return
		
		# Check collision against the target position after the vertical movement
		offset = Point2(0, player.Movement.VerticalDirection)
		collisionState = field.TestCollision(block, offset)
		if collisionState != CollisionState.None:
			# If the first collision test fails the player loses
			hardStuck = false
			if not blockHadInitialCollisionTest:
				hardStuck = collisionState == CollisionState.OutOfBounds or field.TestCollision(block, Point2()) != CollisionState.None			
			OnBlockStuck(hardStuck)
		else:
			block.MoveBy(offset)
		
		blockHadInitialCollisionTest = true
		player.Movement.ResetVerticalTimer()

	# Block hits other block vertically
	private def OnBlockStuck(hardStuck as bool):
		if hardStuck:
			LoseGame()
		else:
			field.Tetrisize(block)
			block.Destroy()
			CheckBlockClearedLine()
			block = null

	# Notifies the player simulation the other player has lost
	def WinGame():
		player.IncreaseScoreForSideClear()

	private def LoseGame():
		gameLost = true

	private def CheckBlockClearedLine():
		verticalBlockRange = block.VerticalRange
		lineClearCount = field.ClearCompletedLinesInRange(verticalBlockRange.x, verticalBlockRange.y, player)
		if lineClearCount > 0:
			player.IncreaseScoreForLineClear(lineClearCount)
		else:
			player.IncreaseScoreForBlockDrop()

	private gameLost as bool

	# The currently active block
	private block as Block

	# States whether the block has been freshly spawned; and not yet has undergone a collision check
	private blockHadInitialCollisionTest as bool

	# The player input of the last frame
	private oldInputState as PlayerInputState
	
	private final player as Player
	private final field as GameField
	private final tetris as TetrisSimulation
	private final blockFactory as BlockFactory