@tool
extends Resource

@export_group("Time", "time_")
@export var time_start: int
@export var time_total: int

@export_group("Map", "map_")
@export var map_scene: PackedScene
@export var map_position: Vector3


static func _static_init() -> void:
	if Engine.is_editor_hint():
		WCSafeResourceFormatSettings.allow()
