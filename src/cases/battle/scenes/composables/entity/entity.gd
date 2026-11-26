#! This should be abstract base class
@abstract
class_name TurnBasedEntity extends Node3D

signal on_turn_ended

@export_group("Agent")
@export var appearance: Node
@export var ai: BTPlayer
@export var data: MobData
@export_category("Internals")
@export var _shaker: ShakerComponent

var shaker: ShakerComponent:
	get:
		return _shaker


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(data.team)

	_shaker.custom_target = true
	_shaker.Targets.clear()
	_shaker.Targets.append(appearance)

	ai.behavior_tree_finished.connect(
		func():
			var mode: String = ai.blackboard.get_var("mode")
			if mode.to_lower() != "idle":
				return
			ai.active = false
			on_turn_ended.emit(),
	)


@abstract
func act(entities: Array[TurnBasedEntity])
