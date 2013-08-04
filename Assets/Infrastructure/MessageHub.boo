import System
import System.Collections.Generic

# Very-simple and incomplete implementation of the event aggregator pattern.
# Warning! You can only implement IMessageHandler once per class and the subscription type must
# be axact
class MessageHub:
	def Publish(message as Message):
		type = message.GetType()
		
		handlers as List[IMessageHandler]
		if dict.TryGetValue(type, handlers):
			for handler in handlers:
				handler.Handle(message)

	def Subscribe[TMessage](handler as IMessageHandler):
		raise "handler must not be null" if handler is null
		type as Type = typeof(TMessage)
		
		handlers as List[IMessageHandler]
		if not dict.TryGetValue(type, handlers):
			handlers = List[of IMessageHandler]()
			dict[type] = handlers
		
		handlers.Add(handler)

	private final dict as Dictionary[of Type, List[of IMessageHandler]] = Dictionary[of Type, List[of IMessageHandler]]()