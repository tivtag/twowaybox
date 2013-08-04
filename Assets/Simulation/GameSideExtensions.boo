
# Defines extension methods for the GameSide enum
static class GameSideExtensions:
	[Extension]
	def GetOpposite(side as GameSide):
		if side == GameSide.Top:
			return GameSide.Bottom
		elif side == GameSide.Bottom:
			return GameSide.Top
		elif side == GameSide.Left:
			return GameSide.Right
		elif side == GameSide.Right:
			return GameSide.Left
		elif side == GameSide.Front:
			return GameSide.Back
		else:
			return GameSide.Front

	[Extension]
	def GetNeighbour(side as GameSide, direction as MoveDirection):
		if side == GameSide.Back:
			if direction == MoveDirection.Left:
				return GameSide.Right
			else:
				return GameSide.Left
		
		elif side == GameSide.Front:
			if direction == MoveDirection.Left:
				return GameSide.Left
			else:
				return GameSide.Right
		
		elif side == GameSide.Left:
			if direction == MoveDirection.Left:
				return GameSide.Back
			else:
				return GameSide.Front
		
		elif side == GameSide.Right:
			if direction == MoveDirection.Left:
				return GameSide.Front
			else:
				return GameSide.Back
		else:
			return GameSide.None