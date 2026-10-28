class_name MobData extends Resource

# What's in an entity?
#
# Data
# - Name
# - Nickname?
# - Health
# - Attack
# - Speed
# - Defense?
#
# View
# - Animation Library
# - Animation Node State
# or...
# - Scene
#
# Flavor
# - AnimationTree?

@export var battle_scene: PackedScene
@export var field_scene: PackedScene

@export_group("Data")
@export var name: String
@export var nickname: String
@export var attributes: Dictionary[StringName, MobAttribute]

@export_subgroup("Flavor Text")
@export var spawn_dialogue: DialogueResource
@export var battle_dialogue: DialogueResource
@export var other_dialogue: DialogueResource
