extends Node

@export var scripts: Array[GDScript]
@export var target_id: StringName


func _ready() -> void:
	var global_manager := MultiSceneManager.managers[&"global"]
	global_manager.queue_remove_scenes()
	global_manager.queue_set_scene(target_id)
	global_manager.apply()

	for script in scripts:
		script.new()
