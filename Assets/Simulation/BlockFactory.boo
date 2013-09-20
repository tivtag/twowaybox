import System.Collections.Generic
import UnityEngine

# Builds Blocks based on BlockTemplates
# The TGM Rotation System is used: http://harddrop.com/wiki/TGM_Rotation
class BlockFactory:
	# Raised when one of the players spawns a new block
	event BlockSpawned as EventHandler[of BlockEventArgs]

	def constructor():
		Register(BlockTemplate('J', 
			(BlockRotation(((0, 0, 0), 
							(1, 1, 1),
							(0, 0, 1))),
			 BlockRotation(((0, 1, 0), 
							(0, 1, 0),
							(1, 1, 0))),
			 BlockRotation(((0, 0, 0),
							(1, 0, 0), 
							(1, 1, 1))),
			 BlockRotation(((0, 1, 1), 
							(0, 1, 0),
							(0, 1, 0))))))
		
		Register(BlockTemplate('L', 
			(BlockRotation(((0, 0, 0),
							(1, 1, 1),
							(1, 0, 0))),
			 BlockRotation(((1, 1, 0), 
							(0, 1, 0),
							(0, 1, 0))),
			 BlockRotation(((0, 0, 0),
							(0, 0, 1), 
							(1, 1, 1))),
			 BlockRotation(((0, 1, 0), 
							(0, 1, 0),
							(0, 1, 1))))))
		
		Register(BlockTemplate('O', 
			(BlockRotation(((0, 0, 0, 0),
							(0, 1, 1, 0), 
						    (0, 1, 1, 0))),)))
		 
		Register(BlockTemplate('I', 2, /* spawn offset white */
			(BlockRotation(((0, 0, 0, 0), 
							(1, 1, 1, 1),
							(0, 0, 0, 0),
							(0, 0, 0, 0))),
			 BlockRotation(((0, 0, 1, 0), 
							(0, 0, 1, 0),
							(0, 0, 1, 0),
							(0, 0, 1, 0))))))
		
		Register(BlockTemplate('S', 
			(BlockRotation(((0, 0, 0),
							(0, 1, 1), 
							(1, 1, 0))),
			 BlockRotation(((1, 0, 0), 
							(1, 1, 0),
							(0, 1, 0))))))
		
		Register(BlockTemplate('Z', 
			(BlockRotation(((0, 0, 0),
							(1, 1, 0), 
							(0, 1, 1))),
			 BlockRotation(((0, 0, 1), 
							(0, 1, 1),
							(0, 1, 0))))))
		
		Register(BlockTemplate('T', 
			(BlockRotation(((0, 0, 0), 
							(1, 1, 1),
							(0, 1, 0))),
			 BlockRotation(((0, 1, 0), 
							(1, 1, 0),
							(0, 1, 0))),
			 BlockRotation(((0, 0, 0),
							(0, 1, 0), 
							(1, 1, 1))),
			 BlockRotation(((0, 1, 0), 
							(0, 1, 1),
							(0, 1, 0))))))

	private def Register(template as BlockTemplate):
		templates.Add(template)

	def GetRandomTemplate():
		index = Random.Range(0, templates.Count)
		return templates[index]

	def NotifySpawned(block as Block):
		BlockSpawned(self, 	BlockEventArgs(block))

	private final templates as List[of BlockTemplate] = List[of BlockTemplate]()