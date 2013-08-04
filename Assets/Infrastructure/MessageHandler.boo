
interface IMessageHandler:
	def Handle(message as Message)

interface IMessageHandler[TMessage(Message)] (IMessageHandler):
	def Handle(message as TMessage)

abstract class MessageHandler[TMessage(Message)] (IMessageHandler[TMessage]):
	def Handle(message as Message):
		Handle(message cast TMessage)

	abstract def Handle(message as TMessage):
		pass