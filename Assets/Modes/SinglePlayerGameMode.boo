import GameColorExtensions

# Simple single player to-the-end game
# The game speed slightly increases after each score
class SinglePlayerGameMode (IGameMode):
	PlayerColor as GameColor:
		get: return playerColor
		set: playerColor = value

	def constructor(game as Game):
		self.game = game

	def Update():
		pass

	def OnDrawGizmos():
		pass

	def OnGUI():
		pass

	def OnEnter():
		player = game.GetPlayer(self.playerColor)
		game.ClearCountChanged += OnClearCountChanged
		player.Score.Changed += OnPlayerScoreChanged
		
		# Deactive other player
		game.GetPlayer(self.playerColor.GetOpposite()).Active = false

	def OnLeave():
		game.ClearCountChanged -= OnClearCountChanged
		player.Score.Changed -= OnPlayerScoreChanged

	private def OnClearCountChanged(sender as object, e as EventArgs):
		totalClearCount = game.ClearCountWhite + game.ClearCountBlack
		if totalClearCount > 0:
			game.Victory = GameVictory.Neither

	private def OnPlayerScoreChanged(sender as object, e as EventArgs):
		player.Movement.IncreaseVerticalMovementSpeedByFactor(0.005)

	private playerColor as GameColor
	private player as Player
	private final game as Game