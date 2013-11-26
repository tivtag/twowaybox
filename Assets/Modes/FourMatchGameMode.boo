
# Play four matches one after the other,
# the player to clear most sides wins the game
class FourMatchGameMode (IGameMode):
	def constructor(game as Game):
		self.game = game

	def Update():
		if changeSideAfterClearInSeconds > 0.0:
			changeSideAfterClearInSeconds -= Time.deltaTime
			if changeSideAfterClearInSeconds <= 0.0:
				ChangeToFreeGameSide()

	def OnDrawGizmos():
		pass

	def OnGUI():
		pass

	def OnEnter():
		changeSideAfterClearInSeconds = 0.0
		game.ResetFieldsSplit()
		
		game.ClearCountChanged += OnClearCountChanged

	def OnLeave():
		game.ClearCountChanged -= OnClearCountChanged

	private def ChangeToFreeGameSide():
		nextSide = game.GetRandomUnclearedSide()
		game.RequestSideChange(nextSide)

	private def OnClearCountChanged(sender as object, e as EventArgs):
		totalClearCount = game.ClearCountWhite + game.ClearCountBlack
		if totalClearCount == 4:
			if game.ClearCountWhite > game.ClearCountBlack:
				game.Victory = GameVictory.White
			elif game.ClearCountWhite < game.ClearCountBlack:
				game.Victory = GameVictory.Black
			else: 
				game.Victory = GameVictory.Both
		elif totalClearCount > 0:
			changeSideAfterClearInSeconds = 3.0

	private changeSideAfterClearInSeconds as single
	private final game as Game