@icon("res://addons/at-icons/node/function.svg")
class_name VisibilityReducer extends Node

@export var nodes: Dictionary[StringName, Node] = { }


func push(node: Node):
	nodes[node.name] = node


func highlight(key: StringName):
	for node in nodes.values() as Array[Node]:
		if node is Node2D:
			node.visible = false
		if node is Node3D:
			node.visible = false
		if node is Control:
			node.visible = false

	var highlighted := nodes[key]
	if highlighted is Node2D:
		highlighted.visible = true
	if highlighted is Node3D:
		highlighted.visible = true
	if highlighted is Control:
		highlighted.visible = true
