
# A plane in 3D-space for one of the GameSides.
# Mainly used for projecting from and to 3D-space onto cell-space of the plane.
class GamePlane:
	Side as GameSide:
		get: return side

	Normal as Vector3:
		get: return normal

	Distance as single:
		get: return distance

	Center as Vector3:
		get: return normal * distance

	Up as Vector3:
		get: return up

	Right as Vector3:
		get: return right

	def constructor(side as GameSide, normal as Vector3, distance as single):
		self.side = side
		self.normal = normal
		self.distance = distance
		
		up = Vector3.up
		right = Vector3.Cross(normal, up)
		if right == Vector3(0,0,0):
			up = Vector3(normal.z, normal.x, normal.y)
			right = Vector3.Cross(normal, up)
		
		cellProjectionMatrix.m00 = right.x
		cellProjectionMatrix.m01 = right.y
		cellProjectionMatrix.m02 = right.z
		cellProjectionMatrix.m10 = up.x
		cellProjectionMatrix.m11 = up.y
		cellProjectionMatrix.m12 = up.z

	def ToCellSpace(vector as Vector3):
		v = cellProjectionMatrix.MultiplyVector(vector)
		v.x += SimulationConstants.MatrixSize.x / 2
		v.y += SimulationConstants.MatrixSize.y / 2
		return v

	def ToViewSpace(cells as Vector3):
		projCells as Vector3 = (right * cells.x) + (up * cells.y) + (normal * cells.z)
		projCubes = projCells * ViewConstants.CubeSize
		return projCubes

	def ToViewSpace(cells as Point2):
		projCells as Vector3 = (right * cells.x) + (up * cells.y)
		projCubes = projCells * ViewConstants.CubeSize
		return projCubes

	override def ToString():
		return string.Format("Plane[normal={0}, right={1}, up={2}]", normal, right, up)

	private cellProjectionMatrix as Matrix4x4
	private final normal as Vector3
	private final distance as single
	private final right as Vector3
	private final up as Vector3
	private final side as GameSide
