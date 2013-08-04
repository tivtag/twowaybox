
# A message is a beefed up EventArgs
class Message (EventArgs):
	# Raised when this message has started to be processed
	event Handelling as EventHandler

	# Raised when this message has been processed
	event Handled as EventHandler

	def BeginHandle():
		Handelling(self, EventArgs.Empty) if Handelling is not null

	def EndHandle():
		Handled(self, EventArgs.Empty) if Handled is not null