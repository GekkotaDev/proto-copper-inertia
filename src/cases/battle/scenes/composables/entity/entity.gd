#! This should be abstract base class
@icon("res://addons/at-icons/node/human.svg")
class_name TurnBasedEntity extends Node3D

signal turn_ended

@export_group("Agent")
@export var ai: BTPlayer
@export var data: MobData
@export var shaker: ShakerComponent3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(&"battler")
	add_to_group(data.team)


func turn():
	ai.active = true
