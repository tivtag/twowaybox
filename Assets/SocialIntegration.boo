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
		PlayGamesPlatform.DebugLogEnabled = GameConstants.IsDevelopment
		PlayGamesPlatform.Activate()

	def AuthenticateUser():
		Social.localUser.Authenticate({success|enabled = success})

	def ReportScoreSinglePlayer(score as long):
		ReportScore("ScoreSinglePlayer", ("CggI_9aS8BAQAhAB" if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQCA"), score)

	def ReportScoreTwoPlayer(score as long):
		ReportScore("ScoreTwoPlayer", ("CggI_9aS8BAQAhAC" if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQBw"), score)

	# Achievement 2-player
	def ReportAchievementPlayedTwoPlayerMatch(victoryCountBlack as int, victoryCountWhite as int, scoreBlack as int, scoreWhite as int):
		UnlockAchievementPlayOneTwoPlayerMatch()
		
		if victoryCountWhite == 4:
			UnlockAchievementWhiteWinsFourRoundsInTwoPlayerMatch()			
		elif victoryCountBlack == 4:
			UnlockAchievementBlackWinsFourRoundsInTwoPlayerMatch()
		
		totalScore as long = scoreBlack + scoreWhite
		if totalScore > 6000:
			UnlockAchievementTwoPlayerScore6000()
		
		if totalScore > 12000:
			UnlockAchievementTwoPlayerScore12000()
		
		if totalScore > 25000:
			UnlockAchievementTwoPlayerScore25000()
		
		IncrementAchievement10TwoPlayerMatchPlayed()

	# Achievement 1-player
	def ReportAchievementPlayedSinglePlayerMatch(victoryCountBlack as int, victoryCountWhite as int, score as int):
		if victoryCountBlack > 0:
			UnlockAchievementSinglePlayerBlackPlayerWin()
		
		if victoryCountWhite > 0:
			UnlockAchievementSinglePlayerWhitePlayerWin()
		
		if score > 500:
			UnlockAchievementSinglePlayerScore500()

	def ShowLeaderboardUI():
		Social.ShowLeaderboardUI();

	def ShowAchievementsUI():
		Social.ShowAchievementsUI();

	# White Solo
	# Play 1 white 1 - Player game to the end.
	private def UnlockAchievementSinglePlayerWhitePlayerWin():
		UnlockAchievement("SinglePlayerWhitePlayerWin", ("CggI_9aS8BAQAhAF" if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQAw"))

	# Black Solo
	# Play 1 black 1 - Player game to the end.
	private def UnlockAchievementSinglePlayerBlackPlayerWin():
		UnlockAchievement("SinglePlayerBlackPlayerWin", ("CggI_9aS8BAQAhAE" if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQAg"))

	# SCORE SOLO MINI
	# Achieve a score of at least 500 in a 1-player game. You can do it!
	private def UnlockAchievementSinglePlayerScore500():
		UnlockAchievement("SinglePlayerScore500", ("CggI_9aS8BAQAhAL" if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQCw"))
	
	# Score Team Macro
	# Achieve a combined score of at least 6.000 in a 2-player game. Can you play together?
	private def UnlockAchievementTwoPlayerScore6000():
		UnlockAchievement("TwoPlayerScore6000", ("CggI_9aS8BAQAhAI " if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQCQ"))
	
	# Score Team Mini
	# Achieve a combined score of at least 12.000 in a 2-player game. Can you work together?
	private def UnlockAchievementTwoPlayerScore12000():
		UnlockAchievement("TwoPlayerScore12000", ("CggI_9aS8BAQAhAJ " if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQBQ"))

	# Score Team Mega
	# Achieve a combined score of at least 25.000 in a 2-player game. Can you work together as a true team?
	private def UnlockAchievementTwoPlayerScore25000():
		UnlockAchievement("TwoPlayerScore10000", ("CggI_9aS8BAQAhAK" if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQBg"))

	# Multiplayer Fan
	# Play one 2-player match to the end and enjoy doing it!
	private def UnlockAchievementPlayOneTwoPlayerMatch():
		UnlockAchievement("PlayOneTwoPlayerMatch", ("CggI_9aS8BAQAhAD" if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQAQ"))

	# Multiplayer White Madness
	# Play one 2-player match to the end with white winning all 4 rounds!
	private def UnlockAchievementWhiteWinsFourRoundsInTwoPlayerMatch():
		UnlockAchievement("WhiteWinsFourRoundsInTwoPlayerMatch", ("CggI_9aS8BAQAhAH" if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQBA"))

	# Multiplayer Black Madness
	# Play one 2-player match to the end with black winning all 4 rounds!
	private def UnlockAchievementBlackWinsFourRoundsInTwoPlayerMatch():
		UnlockAchievement("BlackWinsFourRoundsInTwoPlayerMatch",  ("CggI_9aS8BAQAhAG" if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQCg"))
	
	# A Real Multiplayer Fan, Yo!
	# Play ten 2-player match to the end and enjoy doing it! Yo!
	private def IncrementAchievement10TwoPlayerMatchPlayed():
		IncrementAchievement("10TwoPlayerMatchPlayed", ("CggI_9aS8BAQAhAM" if GameConstants.IsFreeEdition else "CgkI1uSH4vULEAIQDA"))

	private def UnlockAchievement(name as string, achievementId as string):
		if not enabled:
			return;
		
		Social.ReportProgress(achievementId, 100.0f, {success|UnityEngine.Debug.Log(name + ": " + success)})

	private def ReportScore(name as string, leaderboardId as string, score as long):
		if not enabled:
			return;
		
		Social.ReportScore(score, leaderboardId, {success|UnityEngine.Debug.Log(name + ": " + success)})

	private def IncrementAchievement(name as string, achievementId as string):	
		PlayGamesPlatform.Instance.IncrementAchievement(achievementId, 1, {success|UnityEngine.Debug.Log(name + ": " + success)})

	private enabled as bool
