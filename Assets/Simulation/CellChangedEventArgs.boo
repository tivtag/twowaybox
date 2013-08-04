import System

class CellChangedEventArgs (EventArgs):
	public final Cell as Cell

	def constructor(cell as Cell):
		self.Cell = cell