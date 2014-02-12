
# Holds the version of the game
class GameVersion:	
	private static final Value as System.Version = System.Version(0, 9)	
	public static final Text as string = string.Format( "v{0}.{1}", Value.Major, Value.Minor )
