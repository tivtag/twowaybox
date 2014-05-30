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
			match game.Victory:
				case GameVictory.White:
					ShowVictoryWithScore("! white !", Color.white)
				case GameVictory.Black:
					ShowVictoryWithScore("! black !", Color.black)
				case GameVictory.Both:
					ShowVictoryWithScore("~ draw ~", Color.gray)
				
				case GameVictory.Neither:					
					for text in texts:
						score = game.PlayerSingle.Score.Value
						text.Show(score.ToString(), Color.gray)
				otherwise:					
					for text in texts:
						text.Hide()

	private def ShowVictoryWithScore(text as string, victoryColor as Color):
		for index in range(4):
			texts[index].Show(text, victoryColor)
		
		# Include Score
		texts[GameSide.Top].Show(game.PlayerWhite.Score.Value.ToString(), Color.white)
		texts[GameSide.Bottom].Show(game.PlayerBlack.Score.Value.ToString(), Color.black)

	private final texts as (GamePlaneText) = array(GamePlaneText, GameSide._Count)
	private final game as Game
