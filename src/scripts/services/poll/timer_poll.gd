class_name TimerPoll

enum TimerState {
	FRESH,
	TICKING,
	STOPPED,
}

var is_active:
	get:
		return poll() == TimerState.TICKING

var _timer: Timer
var _state := TimerState.FRESH


func _init(node: Timer) -> void:
	_timer = node
	_timer.timeout.connect(
		func():
			_state = TimerState.STOPPED,
	)


func poll():
	if not _timer.is_stopped():
		_state = TimerState.TICKING
	return _state
