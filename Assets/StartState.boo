
# The start state is active when the game boots up and between matches.
# It allows the player to select a game mode to play or to exit the game.
class StartState (IGameState):
	def constructor(game as Game, gameView as GameView, mainLight as Light, states as GameStateManager, gameModes as GameStateManager, socialIntegration as SocialIntegration, adIntegration as AdIntegration):
		self.game = game
		self.gameView = gameView
		self.light = mainLight
		self.states = states
		self.gameModes = gameModes
		self.socialIntegration = socialIntegration
		self.adIntegration = adIntegration
		self.scoresView = ScoresView(game)
		
		scale = GUIScaler.Scale
		if scale != 1:
			scale *= 0.125 // Only use part-scale
		else:
			scale = 0.0 // Disable extra distance
		gameView.LookAtCenter(Vector3(35 + (35 * scale), 0, 0))

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
		# Game Name
		gameNameStyle = GUIStyle(GUI.skin.GetStyle("Label"))
		gameNameStyle.alignment = TextAnchor.UpperCenter
		gameNameStyle.fontSize = System.Math.Max(21 * GUIScaler.Scale, 13)
		gameNameWidth = Math.Min(340 * GUIScaler.Scale, Screen.width)

		gameName as string
		if GameConstants.IsFreeEdition:
			gameName = "Free Two-Way Box"
		else:
			gameName = "Two-Way Box"
		
		GUI.Label(Rect(Screen.width/2 - (gameNameWidth/2), (45 * GUIScaler.Scale), gameNameWidth, 60 * GUIScaler.Scale), gameName, gameNameStyle)
		
		# Menu Buttons	
		if gameStartCount > 0 and game.Victory == GameVictory.None:
			if MenuButton("Continue game", "Continue playing a running game.. enjoy your break.", 0, -197):
				ContinueGame()
		
		if MenuButton("Start 1P black", "Play black alone - how long can you keep up?", 0, -140):
			StartGame[of SinglePlayerGameMode]({mode|mode.PlayerColor = GameColor.Black})
		
		if MenuButton("Start 1P white", "Play white alone - how long can you keep up?", 0, -107):
			StartGame[of SinglePlayerGameMode]({mode|mode.PlayerColor = GameColor.White})
		
		if MenuButton("Start 2P game", "Two Players - most clears after 4 matches wins!", 0, -50):
			StartGame[of FourMatchGameMode](null)
		
		if MenuButton("Leaderboards", "Show Google Play Games Leaderboards", 0, 7):
			ShowLeaderboardUI()
			RandomizeLightColorInProVersion()
		
		if MenuButton("Achievements", "Show Google Play Games Achievements", 0, 40):
			ShowAchievementsUI()
			RandomizeLightColorInProVersion()

		if GameConstants.IsFreeEdition:
			if MenuButton("Play Ad :)", "Play an ad to support Paul :)", 0, 76):
				adIntegration.ShowAd()
				RandomizeLightColor()
		else:
			if MenuButton("Exit", "Sayounara.", 0, 76):
				ExitGame()
		
		# Tooltip
		if GUI.tooltip.Length > 0:
			tooltipStyle = GUIStyle(GUI.skin.GetStyle("Label"))
			tooltipStyle.alignment = TextAnchor.UpperCenter
			tooltipStyle.fontSize = System.Math.Max(10 * GUIScaler.Scale, 14)
			tooltipWidth = Math.Min(240 * GUIScaler.Scale, Screen.width)
			
			tooltipArea = Rect(Screen.width/2 - (tooltipWidth/2), Screen.height/2 + (120 * GUIScaler.Scale), tooltipWidth, 50 * GUIScaler.Scale)
			GUI.Label(tooltipArea, GUI.tooltip, tooltipStyle)
		
		# Version
		GUI.Label(Rect(3, Screen.height - 20, 200, 20), "Paul Ennemoser | " + GameVersion.Text)
		
		# Hide menu
		e = Event.current;
		if e.type == EventType.KeyDown:
			if e.keyCode == KeyCode.Escape:
				stateMenuOpen = false
		
		# Draw score after a game
		if game.Victory != GameVictory.None:
			scoresView.DrawGUI()

	private def RandomizeLightColorInProVersion():
		if not GameConstants.IsFreeEdition:
			RandomizeLightColor()

	private def GetCenterArea(offsetX as int, offsetY as int):
		area = Rect((Screen.width/2) - (75 * GUIScaler.Scale) + (offsetX * GUIScaler.Scale), Screen.height/2 + ((offsetY+60) * GUIScaler.Scale), 150 * GUIScaler.Scale, 30 * GUIScaler.Scale)
		return area

	private def MenuButton(buttonText as string, buttonTooltip as string, offsetX as int, offsetY as int):
		area = GetCenterArea(offsetX, offsetY)
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
		if initialEnter:
			RandomizeLightColor()
			light.intensity = 22.0
			initialEnter = false
		else:
			light.intensity = 3.5

	private def RandomizeLightColor():
		light.color = Color(UnityEngine.Random.value, UnityEngine.Random.value, UnityEngine.Random.value)

	def OnLeave():
		light.color = Color.white
		light.intensity = 6.0

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

	private def ShowLeaderboardUI():
		socialIntegration.ShowLeaderboardUI()

	private def ShowAchievementsUI():
		socialIntegration.ShowAchievementsUI()

	private angle as single = 90.0
	private upVector as Vector3 = Vector3.down

	private stateMenuOpen as bool
	private gameStartCount as int
	private initialEnter as bool = true

	private final game as Game
	private final gameView as GameView
	private final scoresView as ScoresView
	private final light as Light

	private final socialIntegration as SocialIntegration
	private final adIntegration as AdIntegration
	private final states as GameStateManager
	private final gameModes as GameStateManager
