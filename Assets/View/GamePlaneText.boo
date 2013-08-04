
# Represents a 3D-text that is aligned to a [GamePlane]
class GamePlaneText:
	def constructor(plane as GamePlane, distance as single, textResourceName as string):
		position as Vector3 = plane.Center + (plane.Up * (ViewConstants.CubeSize * 0.85)) + (plane.Normal * distance)
		rotation as Quaternion
		rotation.SetLookRotation(plane.Normal, plane.Up)
		textObject = GameObject.Instantiate(UnityEngine.Resources.Load(textResourceName), position, rotation)
		Hide()

	def Show(text as string, color as Color):
		textObject.renderer.enabled = true
		textObject.renderer.material.color = color
		
		mesh as TextMesh = textObject.GetComponent(TextMesh)
		mesh.text = text

	def Hide():
		textObject.renderer.enabled = false

	private final textObject as GameObject