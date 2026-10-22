class_name DIProvider extends Node

@export var data: Dictionary[String, Variant] = { }
@export var subtree: Node


func _ready() -> void:
	provide()


func provide():
	var subtree_nodes := subtree.find_children("*")

	for node in subtree_nodes:
		if not node.has_method("inject"):
			continue

		if not node.has_meta("injectable"):
			continue

		if node.get_meta("injectable") == false:
			continue

		node.inject(data)
