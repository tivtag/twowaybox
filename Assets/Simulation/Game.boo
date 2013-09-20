import GameSideExtensions

# The actual simulation of the game;
# this does not include any visuals.
class Game:
	# Raised when the game wants to change the active GameSide
	event SideChanging as EventHandler[of GameSideChangeMessage]

	# Raised when the Victory property of any of the sides has changed
	event ClearCountChanged as EventHandler

	# Raised when the Victory property of the game has changed
	event VictoryChanged as EventHandler

	ActiveTetris as TetrisSimulation:
		get: return activeTetris

	ActiveSide as GameSide:
		get: 
			if activeTetris != null:
				return activeTetris.Side
			else:
				return GameSide.None

	IsPaused as bool:
		get: return pauseCounter > 0

	PlayerWhite as Player:
		get: return playerWhite

	PlayerBlack as Player:
		get: return playerBlack

	ClearCountWhite as int:
		get: return clearCountWhite

	ClearCountBlack as int:
		get: return clearCountBlack

	BlockFactory as BlockFactory:
		get: return blockFactory

	Victory as GameVictory:
		get: return victory
		set:
			if value != victory:
				victory = value
				VictoryChanged(self, EventArgs.Empty)

	def constructor():
		CreateTetrises()
		activeTetris = GetTetris(GameSide.Front)

	private def CreateTetrises():
		sideSize = SimulationConstants.MatrixSize 
		coverSize = SimulationConstants.CoverSize
		CreateTetris(GameSide.Back,   sideSize)
		CreateTetris(GameSide.Front,  sideSize)
		CreateTetris(GameSide.Left,   sideSize)
		CreateTetris(GameSide.Right,  sideSize)
		CreateTetris(GameSide.Bottom, coverSize)
		CreateTetris(GameSide.Top,    coverSize)
	
	private def CreateTetris(side as GameSide, size as Point2):
	 	tetris = TetrisSimulation(side, size, playerBlack, playerWhite, blockFactory)
	 	tetris.VictoryChanged += OnSideVictoryChanged
	 	
	 	tetrises[side] = tetris

	def Update():
		if not IsPaused:
			activeTetris.Update()

	def StartNew():
		Reset()
		RequestSideChange(GameSide.Front)

	def BeginPause():
		pauseCounter += 1

	def EndPause():
		pauseCounter -= 1

	def Reset():
		Victory = GameVictory.None
		playerBlack.Reset()
		playerWhite.Reset()
		
		for tetris in tetrises:
			tetris.Reset()

    # Change active game side
	def RequestSideChange(newSide as GameSide):
		# Only allow one active side change
		if sideChange is not null:
			return
		
		sideChange = GameSideChangeMessage(ActiveSide, newSide)
		sideChange.Handled += OnSideChanged
		
		BeginPause()
		SideChanging(self, sideChange)

	private def OnSideChanged(sender, e):
		activeTetris = GetTetris(sideChange.NewSide)
		
		sideChange = null
		EndPause()

	private def OnSideVictoryChanged():
		clearCountWhite = GetClearCount(GameColor.White)
		clearCountBlack = GetClearCount(GameColor.Black)
		
		if ClearCountChanged != null:
			ClearCountChanged(self, EventArgs.Empty)

	def GetClearCount(color as GameColor):
		count = 0
		for tetris in tetrises:
			if tetris.Victory == color:
				count += 1
		return count

	def GetTetris(side as GameSide):
		return tetrises[side]

	def GetRandomUnclearedSide():
		uncleared = [tetris.Side for tetris in tetrises 
					if tetris.Victory == GameColor.None and not(tetris.Side == GameSide.Top or tetris.Side == GameSide.Bottom)]
		
		if uncleared.Count == 0:
			return GameSide.None
		
		return uncleared[UnityEngine.Random.Range(0, uncleared.Count-1)]
	
	def GetPlayer(color as GameColor):
		if color == GameColor.White:
			return playerWhite
		elif color == GameColor.Black:
			return playerBlack
		else:
			return null

	# Gets the neighbour side of the active side in the given direction
	def GetNeighbourSide(direction as MoveDirection):
		return activeTetris.Side.GetNeighbour(direction)

	private activeTetris as TetrisSimulation

	private pauseCounter as int
	private sideChange as GameSideChangeMessage

	private clearCountWhite as int
	private clearCountBlack as int
	private victory as GameVictory

	private final playerBlack as Player = Player(GameColor.Black)
	private final playerWhite as Player = Player(GameColor.White)
	private final tetrises as (TetrisSimulation) = array(TetrisSimulation, GameSide._Count)
	private final blockFactory as BlockFactory = BlockFactory()