import System
import GooglePlayGames
 
class SocialIntegration:
	Enabled as bool:
		get:
			return enabled

	def constructor():
		Initialize()
		AuthenticateUser()

	def Initialize():
		// recommended for debugging:
		PlayGamesPlatform.DebugLogEnabled = true
		// Activate the Google Play Games platform
		PlayGamesPlatform.Activate()

	def AuthenticateUser():
	    Social.localUser.Authenticate({success|enabled = success})

	def ReportScoreSinglePlayer(score as long):
		if not enabled:
			return;
		
		Social.ReportScore(score, "CgkI1uSH4vULEAIQCA", {success|UnityEngine.Debug.Log("ReportScoreSinglePlayer: " + success)})

	def ReportScoreTwoPlayer(score as long):
		if not enabled:
			return;
		
		Social.ReportScore(score, "CgkI1uSH4vULEAIQBw", {success|UnityEngine.Debug.Log("ReportScoreTwoPlayer: " + success)})

	def ShowLeaderboardUI():
    	Social.ShowLeaderboardUI();

	def ShowAchievementsUI():
    	Social.ShowAchievementsUI();

	private enabled as bool
