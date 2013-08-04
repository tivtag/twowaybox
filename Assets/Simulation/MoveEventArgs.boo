import System

class MoveEventArgs (EventArgs):
	Offset as Point2:
		get: return offset

	def constructor(offset as Point2):
		self.offset = offset

	private final offset as Point2