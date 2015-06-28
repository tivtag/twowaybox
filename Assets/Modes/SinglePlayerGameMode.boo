import GameColorExtensions

# Simple single player to-the-end game
# The game speed slightly increases after each score
class SinglePlayerGameMode (IGameMode):
	PlayerColor as GameColor:
		get: return playerColor
		set: playerColor = value

	def constructor(game as Game, socialIntegration as SocialIntegration):
		self.game = game
		self.socialIntegration = socialIntegration

	def Update():
		pass

	def OnDrawGizmos():
		pass

	def OnGUI():
		pass

	def OnEnter():
		player = game.GetPlayer(self.playerColor)
		Reset()
		
		# Deactive other player
		oppositeColor = self.playerColor.GetOpposite()
		game.GetPlayer(oppositeColor).Active = false
		
		# Hook events
		game.ClearCountChanged += OnClearCountChanged
		player.Score.Changed += OnPlayerScoreChanged

	def Reset():
		oppositeColor = self.playerColor.GetOpposite()
		game.ResetFields(oppositeColor)

	def OnLeave():
		game.ClearCountChanged -= OnClearCountChanged
		player.Score.Changed -= OnPlayerScoreChanged

	private def OnClearCountChanged(sender as object, e as EventArgs):
		totalClearCount = game.ClearCountWhite + game.ClearCountBlack
		if totalClearCount > 0:
			game.Victory = GameVictory.Neither
			socialIntegration.ReportScoreSinglePlayer(player.Score.Value)

	private def OnPlayerScoreChanged(sender as object, e as EventArgs):
		player.Movement.IncreaseVerticalMovementSpeedByFactor(0.0025)

	private playerColor as GameColor
	private player as Player
	private final socialIntegration as SocialIntegration
	private final game as Game
