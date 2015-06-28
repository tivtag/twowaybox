
# Play four matches one after the other,
# the player to clear most sides wins the game
class FourMatchGameMode (IGameMode):
	def constructor(game as Game, socialIntegration as SocialIntegration):
		self.game = game
		self.socialIntegration = socialIntegration

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
		Reset()
		game.ClearCountChanged += OnClearCountChanged

	def Reset():
		changeSideAfterClearInSeconds = 0.0
		game.ResetFieldsSplit()

	def OnLeave():
		game.ClearCountChanged -= OnClearCountChanged

	private def ChangeToFreeGameSide():
		nextSide = game.GetRandomUnclearedSide()
		game.RequestSideChange(nextSide)

	private def OnClearCountChanged(sender as object, e as EventArgs):
		totalClearCount = game.ClearCountWhite + game.ClearCountBlack
		if totalClearCount == 4:
			OnGameComplete()
		elif totalClearCount > 0:
			changeSideAfterClearInSeconds = 3.0

	private def OnGameComplete():
		if game.ClearCountWhite > game.ClearCountBlack:
			game.Victory = GameVictory.White
		elif game.ClearCountWhite < game.ClearCountBlack:
			game.Victory = GameVictory.Black
		else:
			game.Victory = GameVictory.Both
		
		socialIntegration.ReportScoreTwoPlayer(game.TotalScore)

	private changeSideAfterClearInSeconds as single
	private final game as Game
	private final socialIntegration as SocialIntegration
