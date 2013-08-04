
# Represents a reusable schema for a Tetromino, including all of its rotations
class BlockTemplate:
	Name as string:
		get: return name

	# Gets the size of the blocks created using this template. The size of each rotation is equal.
	Size as Point2:
		get: return rotations[0].Size

	# Gets the number of different rotation states a block using this template can be in
	RotationCount as int:
		get: return rotations.Length

	# Gets the offset on the y-axis of the block spawn location for the white player 
	SpawnOffsetWhiteY as int:
		get: return spawnOffsetWhiteY 

	def constructor(name as string, spawnOffsetWhiteY as int, rotations as (BlockRotation)):
		self.name = name
		self.rotations = rotations
		self.spawnOffsetWhiteY = spawnOffsetWhiteY

	def constructor(name as string, rotations as (BlockRotation)):
		self.name = name
		self.rotations = rotations

	def GetRotationIndex(current as int, offset as int):
		next = (current + offset) % rotations.Length
		return next

	def GetRotation(index as int):
		return rotations[index]

	private final spawnOffsetWhiteY as int
	private final name as string
	private final rotations as (BlockRotation)