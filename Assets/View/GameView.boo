import GameSideExtensions

# The main visualization of the Game
class GameView:
	Camera as Camera:
		get: return camera

	def constructor(game as Game, camera as Camera, selector as MaterialSelector):
		self.game = game
		self.camera = camera
		self.blockViewFactory = BlockViewFactory(selector)
		CreateFieldViews(selector)
		HookEvents()
		
		self.scoresView = ScoresView(game)
		self.victoryView = GameVictoryView(game, self)

	private def CreateFieldViews(selector as MaterialSelector):
		sideLength = ViewConstants.HalfWorldSize.x
		coverLength = ViewConstants.HalfWorldSize.y
		
		CreateTetrisView(GamePlane(GameSide.Back,   Vector3(-1,  0,   0), sideLength), selector)
		CreateTetrisView(GamePlane(GameSide.Front,  Vector3( 1,  0,   0), sideLength), selector)
		CreateTetrisView(GamePlane(GameSide.Left,   Vector3( 0,  0,   1), sideLength), selector)
		CreateTetrisView(GamePlane(GameSide.Right,  Vector3( 0,  0,  -1), sideLength), selector)
		CreateTetrisView(GamePlane(GameSide.Bottom, Vector3( 0, -1,   0), coverLength), selector)
		CreateTetrisView(GamePlane(GameSide.Top,    Vector3( 0,  1,   0), coverLength), selector)

	private def CreateTetrisView(plane as GamePlane, selector as MaterialSelector):
		tetris = game.GetTetris(plane.Side)
		tetrisViews[plane.Side] = TetrisView(tetris, plane, selector)

	private def HookEvents():
		game.SideChanging += OnGameSideChanging
		game.BlockFactory.BlockSpawned += OnBlockSpawned

	def Update():
		if cameraTransition is not null:
			cameraTransition.Update()

	def DrawGizmos():
		if tetrisViews != null:
			for view in tetrisViews:
				view.DrawGizmos()

	def DrawGUI():
		scoresView.DrawGUI()

	private def OnGameSideChanging(sender as object, message as GameSideChangeMessage):
		sideChange = message
		message.BeginHandle()
		
		LookAt(GetTetrisView(message.NewSide))
		cameraTransition.Finished += OnGameSideCameraTransitionFinished	

	private def OnGameSideCameraTransitionFinished(sender as object, e as EventArgs):
		# The transition is done; now we can let the game simulation know
		sideChange.EndHandle()
		sideChange = null
		
		cameraTransition.Finished -= OnGameSideCameraTransitionFinished
		cameraTransition = null

	private def OnBlockSpawned(sender as object, e as BlockEventArgs):
		block = e.Block
		plane = GetTetrisView(block.Side).Plane
		blockViewFactory.BuildBasedOn(block, plane)		

	def GetTetrisView(side as GameSide):
		return tetrisViews[side]

	def GetOpposite(tetrisView as TetrisView):
		if tetrisView is not null:
			return GetTetrisView(tetrisView.Side.GetOpposite())
		else:
			return null

	def LookAt(tetrisView as TetrisView):
		LookAt(tetrisView, ViewConstants.CameraTransitionTime)

	def LookAt(tetrisView as TetrisView, transitionTime as single):
		# oldOpposite = GetOpposite(activeTetrisView)
		newOpposite = GetOpposite(tetrisView)
		
		oppositePlane = newOpposite.Plane
		targetPosition = oppositePlane.Center - oppositePlane.Normal * ViewConstants.CameraOffsetFactor
		targetTarget = tetrisView.Plane.Center
		
		cameraTransition = SmoothCameraTransition(camera, camera.transform.position, camera.transform.forward, targetPosition, targetTarget, transitionTime)
		activeTetrisView = tetrisView
		
		# oldOpposite.Visible = true if oldOpposite is not null
		# newOpposite.Visible = false

	def LookAtCenter(offset as Vector3):
		camera.transform.position = offset
		camera.transform.LookAt(Vector3.zero)

	def RotateCameraAroundCenter(up as Vector3, speed as single):
		camera.transform.RotateAround(Vector3.zero, up, speed)

	private sideChange as GameSideChangeMessage
	private cameraTransition as SmoothCameraTransition

	private activeTetrisView as TetrisView
	private final tetrisViews as (TetrisView) = array(TetrisView, GameSide._Count)
	private final scoresView as ScoresView
	private final victoryView as GameVictoryView

	private final camera as Camera
	private final blockViewFactory as BlockViewFactory
	private final game as Game