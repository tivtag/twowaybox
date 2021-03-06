import UnityEngine
import GameSideExtensions

# The entry script that is started by Unity
class Main (MonoBehaviour):	
	public BlackCubePrefab as GameObject
	public WhiteCubePrefab as GameObject
	public FillerCubePrefab as GameObject

	public MainCamera as Camera
	public MainLight as Light

	def Start():
		SimulationConstants.Configure()
		socialIntegration = SocialIntegration()
		adIntegration = AdIntegration()
		
		game = Game()
		gameView = GameView(game, MainCamera, MaterialSelector(BlackCubePrefab, WhiteCubePrefab, FillerCubePrefab))
		
		# Game Modes
		gameModes.Register(FourMatchGameMode(game, socialIntegration))
		gameModes.Register(SinglePlayerGameMode(game, socialIntegration))
		
		# States
		states.Register(StartState(game, gameView, MainLight, states, gameModes, socialIntegration, adIntegration))
		states.Register(GameState(game, gameView, states, gameModes))
		
		states.ChangeTo[of StartState]() 

	def Update():
		if states != null:
			states.Update()

	def OnDrawGizmos():
		if states != null:
			states.OnDrawGizmos()

	def OnGUI():
		if states != null:
			states.OnGUI()

	private final states as GameStateManager = GameStateManager()
	private final gameModes as GameStateManager = GameStateManager()
