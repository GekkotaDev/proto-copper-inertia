@icon("res://addons/at-icons/node/function.svg")
class_name VisibilityReducer extends Node

@export var test: Script
@export var nodes: Dictionary[StringName, Node] = { }

@export_group("Call", "call_")
@export var call_enabled: bool
@export var call_function: StringName
@export var call_parameters: Array[Variant]


func push(node: Node):
	nodes[node.name] = node


func dispatch(key: StringName, parameters: Array[Variant] = []) -> Node:
	print("test")
	if not nodes.has(key):
		return

	for node in nodes.values() as Array[Node]:
		if "visible" in node:
			node.visible = false

	var highlighted := nodes[key]
	if "visible" in highlighted:
		highlighted.visible = true
	if call_enabled and call_function in highlighted:
		var callable: Callable = nodes.get(call_function)
		callable.callv(call_parameters if parameters.is_empty() else parameters)
	return highlighted
