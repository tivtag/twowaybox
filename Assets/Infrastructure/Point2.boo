
# Represents a point in N²
struct Point2:
	x as int
	y as int

	def constructor(x as int, y as int):
		self.x = x
		self.y = y

	static def op_Addition(a as Point2, b as Point2):
		a.x += b.x
		a.y += b.y
		return a

	static def op_Subtraction(a as Point2, b as Point2):
		a.x -= b.x
		a.y -= b.y
		return a

	static def op_Division(a as Point2, b as int):
		a.x /= b
		a.y /= b
		return a