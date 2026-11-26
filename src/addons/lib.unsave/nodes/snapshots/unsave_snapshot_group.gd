@tool

@abstract
class_name UnsaveSnapshotGroup extends UnsaveSnapshot

@export var groups: Array[StringName] = []


func _ready() -> void:
	pass


func query_nodes() -> Array[Node]:
	var nodes: Array[Node] = []

	for group in groups:
		nodes.append_array(get_tree().get_nodes_in_group(group))

	return nodes
