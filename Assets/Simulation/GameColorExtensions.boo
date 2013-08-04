
# Defines extension methods for the GameColor enum
static class GameColorExtensions:
	[Extension]
	def GetOpposite(color as GameColor):
		if color == GameColor.White:
			return GameColor.Black
		elif color == GameColor.Black:
			return GameColor.White
		else:
			return GameColor.None