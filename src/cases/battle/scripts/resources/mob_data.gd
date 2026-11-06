class_name MobData extends Resource

signal inflicted

@export var rid := get_rid()

@export_group("Scenes")
@export var battle_scene: PackedScene
@export var field_scene: PackedScene

@export_group("Data")
@export var team: StringName
@export var name: String
@export var nickname: String
@export var attributes: Dictionary[StringName, MobAttribute]
@export var moves: Dictionary[StringName, MobMove]
@export var statuses: Dictionary[StringName, MobStatus]

@export_subgroup("Flavor Text")
@export var spawn_dialogue: DialogueResource
@export var battle_dialogue: DialogueResource
@export var other_dialogue: DialogueResource
