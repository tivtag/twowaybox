
# Visualization of a single [TetrisSimulation]
class TetrisView:
	Side as GameSide:
		get: return tetris.Side

	Plane as GamePlane:
		get: return fieldView.Plane

	def constructor(tetris as TetrisSimulation, plane as GamePlane, materialSelector as MaterialSelector):		
		self.tetris = tetris
		self.fieldView = GameFieldView(tetris.Field, plane, materialSelector)
		self.victoryView = TetrisVictoryView(tetris, plane)

	def DrawGizmos():
		fieldView.DrawGizmos()

	private final tetris as TetrisSimulation
	private final fieldView as GameFieldView
	private final victoryView as TetrisVictoryView