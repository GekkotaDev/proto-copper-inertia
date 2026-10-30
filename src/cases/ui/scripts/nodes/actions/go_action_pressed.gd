@tool
class_name GoActionPressed extends GoActionControl

@export var button: BaseButton


func _ready() -> void:
	super()
	var parent := get_parent()

	if button == null and parent is BaseButton:
		button = parent

	button.pressed.connect(trigger)
