
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
		states.ChangeTo[of StartState]()

	private def HandleInput():
		HandleKeyboardInput()
		HandleTouchInput()	

	private def HandleKeyboardInput():
		e = Event.current
		if e.type == EventType.KeyDown and e.keyCode == KeyCode.Escape:
			ChangeToStartState()
	
	# Allow the player to pause the game by touching the center of the screen
	private def HandleTouchInput():		
		if Input.touchCount > 0:
			touch = Input.GetTouch(0)
			
			halfHeight = 60 * GUIScaler.Scale			
			area = Rect(0, (Screen.height/2) - halfHeight, Screen.width, halfHeight*2)
					
			if area.Contains(touch.position):				
				if touch.phase == TouchPhase.Began:
					allowTouchSwitchToMainScreen = true			
				elif allowTouchSwitchToMainScreen and touch.phase == TouchPhase.Ended:	
					ChangeToStartState()
				elif touch.phase == TouchPhase.Canceled:
					allowTouchSwitchToMainScreen = false
		else:		
			allowTouchSwitchToMainScreen = false
	
	private def OnGameVictoryChanged():
		if game.Victory != GameVictory.None:
			ChangeToStartState()

	def OnEnter():
		pass

	def Reset():
		allowTouchSwitchToMainScreen = false
		game.StartNew()

	def OnLeave():
		pass
	
	private allowTouchSwitchToMainScreen as bool

	private final game as Game
	private final gameView as GameView
	private final states as GameStateManager
	private final gameModes as GameStateManager
