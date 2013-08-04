import UnityEngine

# A transition animation of the camera position and camera target to a new position and target
class SmoothCameraTransition:
	event Finished as EventHandler

	def constructor(camera as Camera, sourcePosition as Vector3, sourceTarget as Vector3, targetPosition as Vector3, targetTarget as Vector3, totalTime as single):
		self.sourcePosition = sourcePosition
		self.sourceTarget = sourceTarget
		self.targetPosition = targetPosition
		self.targetTarget = targetTarget
		self.totalTime = totalTime
		self.camera = camera

	def Update():
		if hasFinished or camera is null:
			return
		
		currentTime += Time.deltaTime
		t = Math.Min(1.0, currentTime / totalTime)
		
		currentTarget = Vector3.Slerp(sourceTarget, targetTarget, t)
		currentPosition = Vector3.Slerp(sourcePosition, targetPosition, t)
		
		camera.transform.position = currentPosition
		camera.transform.LookAt(currentTarget)
		
		if currentTime >= totalTime:
			OnFinished()
			return

	private def OnFinished():
		hasFinished = true
		Finished(self, EventArgs.Empty) if Finished is not null	

	private hasFinished as bool

	private sourcePosition as Vector3
	private currentPosition as Vector3
	private final targetPosition as Vector3

	private sourceTarget as Vector3
	private currentTarget as Vector3
	private final targetTarget as Vector3

	private currentTime as single
	private final totalTime as single

	private final camera as Camera