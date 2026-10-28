class_name SignalPoll

var parameters := []
var fired:
	get:
		if _awaited:
			_awaited = false
			return true
		return false

var _awaited := false


func _init(awaitable: Signal) -> void:
	awaitable.connect(
		func(...arguments):
			parameters = arguments
			_awaited = true,
	)
