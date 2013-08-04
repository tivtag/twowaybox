
# Defines math related helper functions
static class MathHelper:
	def Multiply(v1 as Vector3, v2 as Vector3):
		return Vector3(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z)

	def Rotate(vector as Vector2, angle as single):
		cos = System.Math.Cos(angle)
		sin = System.Math.Sin(angle)
		
		return Vector2((vector.x * cos) - (vector.y * sin), (vector.x * sin) + (vector.y * cos))

	def Rotate(vector as Vector2, center as Vector2, angle as single):
		delta = vector - center
		delta = Rotate(delta, angle)
		
		result = delta + center
		return result

	def Round(vector as Vector2):
		return Vector2(vector.x cast int, vector.y cast int)