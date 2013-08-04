
# Shows the victory state of a single tetris game
# E.g. "Black Victory!"
class TetrisVictoryView:
	def constructor(tetris as TetrisSimulation, plane as GamePlane):
		self.tetris = tetris
		self.victoryText = GamePlaneText(plane, 0.0, "VictoryText")
		
		tetris.VictoryChanged += OnVictoryChanged
		OnVictoryChanged()

	private def OnVictoryChanged():
		if tetris.Victory == GameColor.White:
			victoryText.Show("White Victory!", Color.white)
		elif tetris.Victory == GameColor.Black:
			victoryText.Show("Black Victory!", Color.black)
		else:
			victoryText.Hide()

	private final victoryText as GamePlaneText
	private final tetris as TetrisSimulation