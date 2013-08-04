
# The main game states in which the game plays
# See [IGameMode]s for winning conditions.
class GameState (IGameState):
	def constructor(game as Game, gameView as GameView, states as GameStateManager, gameModes as GameStateManager):		
		self.game = game
		self.gameView = gameView
		self.states = states
		self.gameModes = gameModes
		
		game.VictoryChanged += OnGameVictoryChanged

	def Update():
		game.Update()
		gameView.Update()
		gameModes.Update()

	def OnDrawGizmos():
		if gameView != null:
			gameView.DrawGizmos()
			gameModes.OnDrawGizmos()

	def OnGUI():
		HandleInput()
		if gameView != null:
			gameView.DrawGUI()
			gameModes.OnGUI()

	private def ChangeToStartState():
		gameModes.ChangeToNone()
		states.ChangeTo[of StartState]()

	private def HandleInput():
		e = Event.current;
		if e.type == EventType.KeyDown and e.keyCode == KeyCode.Escape:
			ChangeToStartState()

	private def OnGameVictoryChanged():
		if game.Victory != GameColor.None:
			ChangeToStartState()

	def OnEnter():
		game.StartNew()

	def OnLeave():
		pass

	private final game as Game
	private final gameView as GameView
	private final states as GameStateManager
	private final gameModes as GameStateManager