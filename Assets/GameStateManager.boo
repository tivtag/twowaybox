
import System.Collections.Generic

# Manages the broad [IGameState]s of the game. 
# In this simple implementation only one game state is managed at the same time (compared to e.g. a stack based implementation)
class GameStateManager:
	Active as IGameState:
		get: return activeState

	def Register(state as IGameState):
		states.Add(state)

	def Get[of T]():
		for state as IGameState in states:
			if state.GetType() == typeof(T):
				return state
		
		return null

	def ChangeTo[of T]():
		return Set(Get[of T]())

	def ChangeToNone():
		Set(null)

	def Set(newState as IGameState):
		if newState != activeState:
			if activeState != null:
				activeState.OnLeave()
			activeState = newState
			if newState != null:
				newState.OnEnter()
					
		return newState

	def Update():
		if activeState != null:
			activeState.Update()

	def OnDrawGizmos():
		if activeState != null:
			activeState.OnDrawGizmos()

	def OnGUI():
		if activeState != null:
			activeState.OnGUI()

	private activeState as IGameState
	private final states as List[of IGameState] = List[of IGameState]()
