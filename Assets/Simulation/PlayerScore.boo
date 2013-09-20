
# Holds the game score of a single [Player]
class PlayerScore:
	event Changed as EventHandler

	Value as long:
		get: return score
		private set:
			if score != value:
				score = value
				Changed(self, EventArgs.Empty) unless Changed is null

	def IncreaseForLineClear(lineClearCount as int):
		Value += 10 * lineClearCount * lineClearCount * lineClearCount

	def IncreaseForBlockDrop():
		Value += 1

	def IncreaseForSideClear():
		Value += 1000

	def Reset():
		Value = 0

	private score as long
