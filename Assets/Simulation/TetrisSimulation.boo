
# Simulates a single 2D-tetris game; a single side in the 3D-game
class TetrisSimulation:
	# Raised when the Victory property has changed
	event VictoryChanged as EventHandler

	# Gets or sets the color of the player that has won this 2D-tetris game	
	Victory as GameColor:
		get: return victory
		set:
			if value != victory:
				victory = value
				VictoryChanged(self, EventArgs.Empty) if VictoryChanged != null

	Field as GameField:
		get: return field

	Side as GameSide:
		get: return side

	def constructor(side as GameSide, size as Point2, playerBlack as Player, playerWhite as Player, blockFactory as BlockFactory):
		self.side = side
		self.field = GameField(size)
		
		self.simulationBlack = TetrisPlayerSimulation(playerBlack, self, blockFactory)
		self.simulationWhite = TetrisPlayerSimulation(playerWhite, self, blockFactory)

	def Update():
		if victory == GameColor.None:
			simulationBlack.Update()
			simulationWhite.Update()
			CheckVictoryStates()

	private def CheckVictoryStates():
		if simulationBlack.GameLost:
			WinGame(simulationWhite)
		elif simulationWhite.GameLost:
			WinGame(simulationBlack)

	private def WinGame(simulation as TetrisPlayerSimulation):
		color = simulation.Color
		field.SetRow(field.Size.x/2 - 2, color)
		field.SetRow(field.Size.x/2 - 1, color.GetOpposite())
		field.SetRow(field.Size.x/2 + 0, color.GetOpposite())
		field.SetRow(field.Size.x/2 + 1, color)
		
		simulation.WinGame()
		self.Victory = color

	def Reset():
		Victory = GameColor.None
		simulationBlack.Reset()
		simulationWhite.Reset()
		field.Reset()

	# The color of the player that won this Tetris game
	private victory as GameColor

	private final side as GameSide
	private final field as GameField
	private final simulationBlack as TetrisPlayerSimulation
	private final simulationWhite as TetrisPlayerSimulation