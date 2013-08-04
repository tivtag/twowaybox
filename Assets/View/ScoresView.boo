
# Draws the current Score and Clear Count (e.g. how many sides were won) of both players 
class ScoresView:
	def constructor(game as Game):
		self.game = game

	def DrawGUI():
		style = GUI.skin.GetStyle("Box")
		style.alignment = TextAnchor.MiddleCenter
		
		# Black
		score = game.PlayerBlack.Score
		style.fontSize = GetFontSize(score)
		GUI.Box(Rect(Screen.width-110, 5, 100, 25), score.ToString(), style)
		if game.ClearCountBlack > 0:
			GUI.Box(Rect(Screen.width-85, 35, 50, 25), System.String(char('|'), game.ClearCountBlack), style)
		
		# White
		score = game.PlayerWhite.Score
		style.fontSize = GetFontSize(score)
		GUI.Box(Rect(Screen.width-110, Screen.height - 30, 100, 25), score.ToString(), style)
		if game.ClearCountWhite > 0:
			GUI.Box(Rect(Screen.width-85, Screen.height - 60, 50, 25), System.String(char('|'), game.ClearCountWhite), style)

	private def GetFontSize(score as int):
		if score < 1000:
			return 22
		elif score < 10000:
			return 19
		elif score < 1000000:
			return 18
		else:
			return 16

	private final game as Game