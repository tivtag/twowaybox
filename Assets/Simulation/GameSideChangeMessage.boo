
# Notifies the target of the message that the currently active
# game side has changed. 
#
# E.g. used in the View to start a camera transition from the old to the new side.
class GameSideChangeMessage(Message):
	OldSide as GameSide:
		get: return oldSide

	NewSide as GameSide:
		get: return newSide

	def constructor(oldSide as GameSide, newSide as GameSide):
		self.oldSide = oldSide
		self.newSide = newSide

	private final oldSide as GameSide
	private final newSide as GameSide