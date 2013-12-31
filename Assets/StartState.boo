
# The start state is active when the game boots up and between matches.
# It allows the player to select a game mode to play or to exit the game.
class StartState (IGameState):
	def constructor(game as Game, gameView as GameView, mainLight as Light, states as GameStateManager, gameModes as GameStateManager):
		self.game = game
		self.gameView = gameView
		self.light = mainLight
		self.states = states
		self.gameModes = gameModes
		self.scoresView = ScoresView(game)
		
		gameView.LookAtCenter(Vector3(35, 0, 0))

	def Update():
		rotationSpeed = Time.deltaTime * 20.0
		angle += rotationSpeed
		
		if angle >= 90.0:
			vectors = [Vector3.down, Vector3.up, Vector3.forward, Vector3.back, Vector3.left, Vector3.right]
			oppositeUpVector = -upVector
			
			while true: 
				upVector = vectors[UnityEngine.Random.Range(0, vectors.Count-1)]
				break unless upVector == oppositeUpVector
			
			angle = 0.0
		
		gameView.RotateCameraAroundCenter(upVector, rotationSpeed)

	def OnDrawGizmos():
		if gameView != null:
			gameView.DrawGizmos()

	def OnGUI():
		if GUIScaler.Enabled:
			GUI.skin.button.fontSize = 16 * GUIScaler.Scale
		
		if stateMenuOpen:
			HandleMenuStateGUI()
		else:
			HandleNonMenuStateGUI()

	private def HandleMenuStateGUI():		
		if gameStartCount > 0 and game.Victory == GameVictory.None:
			if MenuButton("Continue game", "Continue playing a running game!", -197):
				ContinueGame()
		
		if MenuButton("Start 1P black", "Play black alone!", -140):
			StartGame[of SinglePlayerGameMode]({mode|mode.PlayerColor = GameColor.Black})
		
		if MenuButton("Start 1P white", "Play white alone!", -107):
			StartGame[of SinglePlayerGameMode]({mode|mode.PlayerColor = GameColor.White})
		
		if MenuButton("Start 2P game", "Two Players - most clears after 4 matches wins!", -50):
			StartGame[of FourMatchGameMode](null)
		
		if MenuButton("Exit", "", 7):
			ExitGame()
		
		centeredLabelStyle = GUI.skin.GetStyle("Label")
		centeredLabelStyle.alignment = TextAnchor.UpperCenter
		GUI.Label(Rect(Screen.width/2 - 130, Screen.height/2 + (80 * GUIScaler.Scale), 260, 40), GUI.tooltip, centeredLabelStyle)
		GUI.Label(Rect(4, Screen.height - 20, 140, 20), "Paul Ennemoser | v0.7")
		
		e = Event.current;
		if e.type == EventType.KeyDown:
			if e.keyCode == KeyCode.Escape:
				stateMenuOpen = false
		
		if game.Victory != GameVictory.None:
			scoresView.DrawGUI()

	private def MenuButton(buttonText as string, buttonTooltip as string, offsetY as int):
		area = Rect((Screen.width/2) - (75 * GUIScaler.Scale), Screen.height/2 + ((offsetY+20) * GUIScaler.Scale), 150 * GUIScaler.Scale, 30 * GUIScaler.Scale)
		return GUI.Button(area, GUIContent(buttonText, buttonTooltip))

	private def HandleNonMenuStateGUI():
		e = Event.current;
		
		if e.type == EventType.KeyDown or e.type == EventType.MouseDown:
			if e.keyCode == KeyCode.Escape:
				ExitGame()
			else:
				stateMenuOpen = true

	private def ExitGame():
		Application.Quit()

	def OnEnter():
		light.intensity = 2.10

	def OnLeave():
		light.color = Color.white
		light.intensity = 5.05

	def Reset():
		pass

	private def ContinueGame():
		states.ChangeTo[of GameState]()
		game.Continue()

	private def StartGame[of TGameMode(IGameMode)](initializer as System.Action[of TGameMode]):
		# Change Game State
		gameState = states.ChangeTo[of GameState]()		
		gameState.Reset()
		
		# Change Game Mode
		mode = gameModes.Get[of TGameMode]()
		if not initializer is null:
			initializer(mode)
			
		gameModes.Set(null)
		gameModes.Set(mode)
		
		gameStartCount += 1

	private angle as single = 90.0
	private upVector as Vector3 = Vector3.down

	private stateMenuOpen as bool
	private gameStartCount as int

	private final game as Game
	private final gameView as GameView
	private final scoresView as ScoresView
	private final light as Light

	private final states as GameStateManager
	private final gameModes as GameStateManager
