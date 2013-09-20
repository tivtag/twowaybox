
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
		if stateMenuOpen:
			HandleMenuStateGUI()
		else:
			HandleNonMenuStateGUI()

	private def HandleMenuStateGUI():
		if GUI.Button(Rect((Screen.width/2) - 100, Screen.height/2 - 140, 150, 30), GUIContent("Start 1P black", "Play black alone!")):
			StartGame[of SinglePlayerGameMode]({mode|mode.PlayerColor = GameColor.Black})
		
		if GUI.Button(Rect((Screen.width/2) - 100, Screen.height/2 - 100, 150, 30), GUIContent("Start 1P white", "Play white alone!")):
			StartGame[of SinglePlayerGameMode]({mode|mode.PlayerColor = GameColor.White})
			
		if GUI.Button(Rect((Screen.width/2) - 100, Screen.height/2 - 60, 150, 30), GUIContent("Start 2P game", "Two Players - most clears after 4 matches wins!")):
			StartGame[of FourMatchGameMode](null)
				
		if GUI.Button(Rect((Screen.width/2) - 100, Screen.height/2 + 10, 150, 30), "Exit"):
			ExitGame()
		
		GUI.Label(Rect((Screen.width/2) - 120, Screen.height/2 + 50, 240, 40), GUI.tooltip)
		GUI.Label(Rect(4, Screen.height - 20, 140, 20), "Paul Ennemoser | v0.3")
		
		e = Event.current;
		if e.type == EventType.KeyDown:
			if e.keyCode == KeyCode.Escape:
				stateMenuOpen = false
		
		if game.Victory != GameVictory.None:
			scoresView.DrawGUI()

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

	private def StartGame[of TGameMode(IGameMode)](initializer as System.Action[of TGameMode]):
		states.ChangeTo[of GameState]()
		mode = gameModes.Get[of TGameMode]()
		if not initializer is null:
			initializer(mode)
		gameModes.Set(mode)

	private angle as single = 90.0
	private upVector as Vector3 = Vector3.down

	private stateMenuOpen as bool

	private final game as Game
	private final gameView as GameView
	private final scoresView as ScoresView
	private final light as Light

	private final states as GameStateManager
	private final gameModes as GameStateManager