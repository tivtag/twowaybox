
# Draws the current Score and Clear Count (e.g. how many sides were won) of both players 
class ScoresView:
	def constructor(game as Game):
		self.game = game

	def DrawGUI():
		DrawScore(game.PlayerBlack, 0)
		DrawScore(game.PlayerWhite, Screen.height - 35)

	private def DrawScore(player as Player, offsetY as int):
		if not player.Active:
			return
		
		style = GUI.skin.GetStyle("Box")
		style.alignment = TextAnchor.MiddleCenter
		
		score = player.Score.Value
		style.fontSize = GetFontSize(score)
		GUI.Box(Rect(Screen.width-110, offsetY + 5, 100, 25), score.ToString(), style)
		
		clearCount = game.GetClearCount(player.Color)
		if clearCount > 0:
			GUI.Box(Rect(Screen.width-85, offsetY + 35, 50, 25), System.String(char('|'), clearCount), style)

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