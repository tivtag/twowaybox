import GameColorExtensions

# Represents the 2D field of cells that make up the tetris game field.
class GameField:
	event CellChanged as EventHandler[CellChangedEventArgs]

	Size as Point2:
		get: return size

	def constructor(size as Point2):
		self.size = size
		self.cells = matrix(GameColor, size.x, size.y)

	def SetCell(cell as Cell):
		if IsValidIndex(cell.Position):
			if cells[cell.Position.x, cell.Position.y] != cell.Color:
				cells[cell.Position.x, cell.Position.y] = cell.Color
				CellChanged(self, CellChangedEventArgs(cell))

	def GetCell(position as Point2):
		if IsValidIndex(position):
			return GetCellUnsafe(position)
		else:
			return GameColor.None

	def GetCellUnsafe(position as Point2):
		return cells[position.x, position.y]

	def TestCollision(block as Block, offset as Point2):
		for cell in block.Cells:
			state = TestCollision(cell, offset)
			if state != CollisionState.None:
				return state
		
		return CollisionState.None

	def TestCollision(cell as Cell, offset as Point2):
		position = cell.Position + offset
		
		if IsValidIndex(position):
			fieldCellColor = GetCellUnsafe(position)
			if fieldCellColor == cell.Color or fieldCellColor == GameColor.None:
				return CollisionState.Collided
			else:
				return CollisionState.None
		else:
			return CollisionState.OutOfBounds

	def Tetrisize(block as Block):
		for cell in block.Cells:
			SetCell(cell)

	def FindCompletedLinesInRange(startRow as int, endRow as int, color as GameColor):
		lines = List[of int]() 
		
		for row in range(startRow, endRow+1):
			if IsRowComplete(row, color):
				lines.Add(row)
		
		return lines

	def ClearCompletedLinesInRange(startRow as int, endRow as int, player as Player):
		lines = FindCompletedLinesInRange(startRow, endRow, player.Color)
		
		if player.Color == GameColor.Black:		
			# The lines are sorted from top to bottom
			for line as int in lines:
				# Move lines above down
				if line != 0:
					for row as int in reversed(range(0, line)):
						CopyRow(row, 1)
				
				# Insert new line on the top
				SetRow(0, player.Color.GetOpposite())
		else:
			# The lines are sorted from bottom to top
			for line as int in reversed(lines):
				# Move lines below up
				if line != (SimulationConstants.WorldEnd.y - 1):
					for row as int in range(line+1, SimulationConstants.WorldEnd.y):
						CopyRow(row, -1)
				
				# Insert new line on the bottom
				SetRow(SimulationConstants.WorldEnd.y-1, player.Color.GetOpposite())
		
		return lines.Count

	private def CopyRow(row as int, offset as int):
		for column in range(SimulationConstants.WorldStart.x, SimulationConstants.WorldEnd.x):
			cellColor = GetCellUnsafe(Point2(column, row))
			SetCell(Cell(Point2(column, row + offset), cellColor))

	private def IsRowComplete(row as int, color as GameColor):
		for column in range(SimulationConstants.WorldStart.x, SimulationConstants.WorldEnd.x):
			cellColor = GetCell(Point2(column, row))
		
			if cellColor != GameColor.None and cellColor != color:
				return false
		
		return true

	def SetRow(row as int, color as GameColor):
		for column in range(SimulationConstants.WorldStart.x, SimulationConstants.WorldEnd.x):
			SetCell(Cell(Point2(column, row), color))

	def IsValidIndex(position as Point2):
		return position.x >= 0 and position.y >= 0 and position.x < size.x and position.y < size.y

	def IsFillerIndex(position as Point2):
		return IsValidIndex(position) and (position.x < SimulationConstants.HalfFillerSize.x or position.x >= (SimulationConstants.MatrixSize.x-SimulationConstants.HalfFillerSize.x))

	def Reset():
		for row in range(size.y):
			for column in range(size.x):
				position = Point2(column, row)
				color = (GameColor.None if IsFillerIndex(position) else (GameColor.Black if (row >= size.y/2) else GameColor.White))
				
				SetCell(Cell(position, color))

	private final size as Point2
	private final cells as (GameColor, 2)