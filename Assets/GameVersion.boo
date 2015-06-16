
# Holds the version of the game
class GameVersion:	
	private static final Value as System.Version = System.Version(1, 2, 0, 6) # Major, Minor, Unused, Revision
	public static final Text as string = string.Format( "v{0}.{1}.{2}", Value.Major, Value.Minor, Value.Revision)
