
static class PlatformHelper:	
	public final IsTouch as bool = [RuntimePlatform.Android, RuntimePlatform.WP8Player, RuntimePlatform.IPhonePlayer].Contains(Application.platform)
	public final IsHighDpi as bool = IsTouch
