
# The state and position of a cell in the [GameField]
struct Cell:
	final Position as Point2
	final Color as GameColor
	
	# Workaround property for "unloaded" bug in MonoDevelop
	debugView_Color as int:
		get: return (self.Color cast int)	

	def constructor(position as Point2, color as GameColor):
		self.Position = position
		self.Color = color