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
				case GameColor.White:
					text.Show("! white !", Color.white)
				case GameColor.Black:
					text.Show("! black !", Color.black)
				case GameColor.Both:
					text.Show("~ draw ~", Color.gray)
				otherwise:
					text.Hide()

	private final texts as (GamePlaneText) = array(GamePlaneText, GameSide._Count)
	private final game as Game