import UnityEngine

class GUIScaler:
	public static final Scale as single = ComputeScale()
	public static final Enabled as bool = Scale != 1.0
	
	private static def ComputeScale():
		scale = Screen.dpi / 95.0
		if scale == 0 or scale < 1.1f or Application.platform != RuntimePlatform.Android:
			return 1.0
		else:
			return scale