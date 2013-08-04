
# The 6 sides of the game cube.
# Each side has an independent [TetrisSimulation].
#
# Only the belt (Front, Back, Left and Right) consists of playable games sides.
enum GameSide:
	Front
	Back
	Left
	Right
	Bottom
	Top
	_Count
	None