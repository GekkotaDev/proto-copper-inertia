@icon("res://addons/at-icons/animation/script.svg")

@tool
class_name GoActionScript extends GoAction


@export var code: GDScript


func _trigger() -> void:
	code.new(self)
