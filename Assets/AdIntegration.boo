import System
import UnityEngine
import UnityEngine.Advertisements

class AdIntegration:
	Enabled as bool:
		get:
			return enabled

	def ShowAd():
		if not enabled:
			return

		if Advertisement.IsReady():
			Advertisement.Show()
	

	private enabled as bool = GameConstants.IsFreeEdition
