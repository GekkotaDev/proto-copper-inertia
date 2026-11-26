@icon("res://addons/at-icons/animation/push_button.svg")

@tool
class_name GoButton extends GoAction


@export var action: GoAction
@export var button: BaseButton


func _assign_button(parent = get_parent()):
	if parent == null:
		return

	if parent is BaseButton:
		button = parent
		return

	return _assign_button(parent.get_parent())


func _ready() -> void:
	_assign_button()
	
	if button:
		button.pressed.connect(_trigger)


func _trigger() -> void:
	action.trigger()
