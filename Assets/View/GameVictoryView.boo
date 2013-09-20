import Boo.Lang.PatternMatching

# Shows the victory state of a full game match
class GameVictoryView:
	def constructor(game as Game, gameView as GameView):
		game.VictoryChanged += OnGameVictoryChanged
		self.game = game
		
		for index in range(texts.Length):
			plane = gameView.GetTetrisView(index).Plane
			texts[index] = GamePlaneText(plane, ViewConstants.CubeSize * -7, "VictoryText")
		
		OnGameVictoryChanged()

	private def OnGameVictoryChanged():
		for text in texts:
			match game.Victory:
				case GameVictory.White:
					text.Show("! white !", Color.white)
				case GameVictory.Black:
					text.Show("! black !", Color.black)
				case GameVictory.Both:
					text.Show("~ draw ~", Color.gray)
				case GameVictory.Neither:
					text.Show("- lost -", Color.gray)
				otherwise:
					text.Hide()

	private final texts as (GamePlaneText) = array(GamePlaneText, GameSide._Count)
	private final game as Game