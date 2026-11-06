@icon("res://addons/at-icons/node/forest.svg")
class_name TreeTemplate extends Node

@export var scope: Node
@export var slots: Dictionary[StringName, Node] = { }


func _ready() -> void:
	scope = scope if scope else get_parent()


func populate(node: Node, slot: StringName):
	slots[slot].replace_by(node)


func auto_populate(nodes: Array[Node]):
	for slot in slots.values() as Array[Node]:
		slot.replace_by(nodes.pop_front())
