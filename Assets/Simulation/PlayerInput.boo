
# Extends the Unity Input class with PlayerInputState parsing and support
# for dynamically injecting input state
class PlayerInput:
	public static final UseInjectedInput as bool = PlatformHelper.IsTouch

	static def GetState(playerColor as GameColor):
		if UseInjectedInput:
			return GetInjectedInput(playerColor)
		else:
			return GetKeyboardInput(playerColor)

	private static def GetKeyboardInput(playerColor as GameColor):
		drop               = Input.GetAxis(playerColor.ToString() + "-Drop") == 1
		horizontalMovement = Input.GetAxis(playerColor.ToString() + "-Horizontal")
		rotateDirection    = Input.GetAxis(playerColor.ToString() + "-Rotate")
		
		return PlayerInputState(horizontalMovement, drop, rotateDirection)

	private static def GetInjectedInput(playerColor as GameColor):
		if playerColor == GameColor.White:
			return whiteState
		else:
			return blackState
	
	static def SetInjectedInput(playerColor as GameColor, state as PlayerInputState):
		if playerColor == GameColor.White:
			whiteState = state
		else:
			blackState = state
	
	private static whiteState as PlayerInputState
	private static blackState as PlayerInputState