class_name AIExecAgent extends Node

signal finished

@export var bt: BTPlayer
@export var juice: JuiceePlayer
@export var properties: AIDataProperties

var is_planning := true


func _ready() -> void:
	bt.active = false
	bt.updated.connect(
		func(status: BT.Status):
			if status != BT.RUNNING:
				bt.active = false
				finished.emit()
	)
