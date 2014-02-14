
# Holds the version of the game
class GameVersion:	
	private static final Value as System.Version = System.Version(1, 0)	
	public static final Text as string = string.Format( "v{0}.{1}", Value.Major, Value.Minor )
