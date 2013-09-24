
# Button-Based input for mobile touch devices
# Currently only optimized for Nexus 7 (2013)
class ButtonInputView:
	def constructor(game as Game):
		self.game = game
	
	def DrawGUI():
		HandleInput(game.PlayerBlack, 0, 180 /* dropButtonRotation*/, false)
		HandleInput(game.PlayerWhite, Screen.height - (screenHeight*0.145), 0 /* dropButtonRotation*/, true)
		
	private def HandleInput(player as Player, offsetY as int, dropButtonRotation as single, exchangeRows as bool):
		if not player.Active or not PlayerInput.UseInjectedInput:
			return
		
		horizontalMovement = 0
		drop = false
		rotateDirection = 0
		offsetRow1 = offsetY + (screenHeight * 0.005)
		offsetRow2 = offsetY + (screenHeight * 0.075)
		heightRow = screenHeight * 0.065
		
		# Drop
		dropButtonRect = Rect(screenWidth*0.42, offsetRow1, screenWidth*0.16, screenHeight*0.135)
		uiMatrix = GUI.matrix
		GUIUtility.RotateAroundPivot(dropButtonRotation, dropButtonRect.center)
		if TouchButton(dropButtonRect, "^"):
			drop = true
		GUI.matrix = uiMatrix
		
		if exchangeRows:
			tmp = offsetRow2
			offsetRow2 = offsetRow1
			offsetRow1 = tmp
		
		# Left/Right
		if TouchButton(Rect(screenWidth*0.01, offsetRow1, screenWidth*0.4, heightRow), "<"):
			horizontalMovement = -1
		if TouchButton(Rect(screenWidth*0.59, offsetRow1, screenWidth*0.4, heightRow), ">"):
			horizontalMovement = 1
		
		# Rotate
		if TouchButton(Rect(screenWidth*0.01, offsetRow2, screenWidth*0.4, heightRow), "l"):
			rotateDirection = -1
		if TouchButton(Rect(screenWidth*0.59, offsetRow2, screenWidth*0.4, heightRow), "r"):
			rotateDirection = 1
		
		PlayerInput.SetInjectedInput(player.Color, PlayerInputState(horizontalMovement, drop, rotateDirection))
	
	private static def TouchButton(area as Rect, text as string):	
		active = false
		
		for touchIndex in range(Input.touchCount):
			touch = Input.GetTouch(touchIndex)
			
			if touch.phase != TouchPhase.Ended and touch.phase != TouchPhase.Canceled:
				screenPosition = Vector2(touch.position.x, screenHeight - touch.position.y)
				if area.Contains(screenPosition):
					active = true
		
		style = GUI.skin.GetStyle("Box")
		style.alignment = TextAnchor.MiddleCenter
		style.fontSize = 30
		
		oldColor = GUI.color
		if active:
			GUI.color = Color.red
		GUI.Box(area, text, style)
		GUI.color = oldColor
		return active
	
	private static final screenWidth = Screen.width
	private static final screenHeight = Screen.height
	private final game as Game