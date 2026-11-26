@icon("res://addons/at-icons/animation/stars.svg")

@tool
class_name GoActionJuice extends GoAction


@export var action: GoAction

@export_group("Juice", "juice_")
@export var juice_parameters: Dictionary[StringName, Variant]
@export var juice_player: JuiceePlayer
@export var juice_name: StringName


func _trigger() -> void:
	if Engine.is_editor_hint():
		Log.info("GoActionJuice not permitted to run inside editor, may cause engine crash.")
		action.trigger()
		return

	var node := get_node(juice_player.target_path)

	for parameter in juice_parameters:
		if node == null:
			break
		node.material.set_shader_parameter(parameter, juice_parameters[parameter])

	juice_player.play(juice_name)
	await juice_player.finished
	action.trigger()
