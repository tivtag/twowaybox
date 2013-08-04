
# Helpers class for drawing debug gizmos
static class GizmoHelper:
	def DrawPlane(plane as GamePlane):
		perp = plane.Up
		perp2 = plane.Right
		center = plane.Center
		length = plane.Distance
		
		Gizmos.color = Color(0, 1, 0, 1)
		Gizmos.DrawLine(Vector3(), center)  
		
		Gizmos.color = Color(1, 0, 0, 1)
		Gizmos.DrawLine(center, center - (perp * length))
		Gizmos.DrawLine(center, center + (perp * length))
		Gizmos.DrawLine(center, center - (perp2 * length))
		Gizmos.DrawLine(center, center + (perp2 * length))