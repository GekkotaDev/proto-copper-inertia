class_name AIDataProperties extends Resource

@export_group("Scenes", "scene_")
@export var scene_field: PackedScene
@export var scene_agent: PackedScene

@export_group("Stats", "stat_")
@export var stat_health: int = int(NAN)
@export var stat_speed: int = int(NAN)
@export var stat_attack: int = int(NAN)
@export var stat_defense: int = int(NAN)
