
interface IGameState:
	def Update()
	def OnDrawGizmos()
	def OnGUI()
	def OnEnter()
	def OnLeave()	
	def Reset()