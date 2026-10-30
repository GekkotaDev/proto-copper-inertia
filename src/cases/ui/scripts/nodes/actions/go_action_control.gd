@tool
@abstract
class_name GoActionControl extends GoAction

@export var dispatch: GoAction


func _ready() -> void:
	if dispatch:
		return

	for child in get_children():
		if child is GoAction:
			dispatch = child
			break


func _trigger() -> void:
	dispatch.trigger()
