@icon("res://addons/at-icons/node/node_graph_root.svg")
class_name NodeComposer extends Node

@export var nodes: Dictionary[StringName, Node]


static func has_composer(nullable_composer: NodeComposer) -> bool:
	return nullable_composer != null


static func get_composer(tree: Node) -> NodeComposer:
	var children := tree.find_children(&"*", &"NodeComposer")
	if children.is_empty():
		return null
	return children[0]
