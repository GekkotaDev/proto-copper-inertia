extends Control

@export_group("Scene")
@export var selected_scene: StringName = ""
@export var scene_map: Dictionary[StringName, PackedScene] = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not scene_map.has(selected_scene):
		Log.error("Scene '{scene_name}' does not exist".format({
			scene_name = selected_scene,
		}))
		await get_tree().create_timer(1.0)
		get_tree().quit(1)
		return

	setup()
	get_tree().change_scene_to_packed(scene_map[selected_scene])


func setup() -> void:
	pass
