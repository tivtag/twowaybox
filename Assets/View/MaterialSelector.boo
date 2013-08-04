import UnityEngine

# Helps selecting the correct unity material prefabs
# used while rendering the cubes
class MaterialSelector:
	def constructor(blackPrefab as GameObject, whitePrefab as GameObject, fillerPrefab as GameObject):
		self.blackPrefab = blackPrefab
		self.whitePrefab = whitePrefab
		self.fillerPrefab = fillerPrefab

	def GetPrefab(color as GameColor):
		if color == GameColor.Black:
			return blackPrefab
		elif color == GameColor.White:
			return whitePrefab
		else:
			return fillerPrefab

	def GetMaterial(color as GameColor):
		return GetPrefab(color).renderer.sharedMaterial

	private blackPrefab as GameObject
	private whitePrefab as GameObject
	private fillerPrefab as GameObject