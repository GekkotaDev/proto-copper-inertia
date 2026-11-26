@tool
class_name GoEmitSignal extends GoAction

@export var out_signal: String
@export var out_parameters: Array[Variant] = []
@export var out_node: Node:
	get:
		return out_node
	set(value):
		out_node = value


func _validate_property(property: Dictionary) -> void:
	if property.name == "in_signal":
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(
			out_node.get_signal_list().map(func(sig): return sig["name"])
		)


func _trigger() -> void:
	var sig = out_node.get(out_signal)

	if sig is Signal:
		sig.emit.callv(out_parameters)


func emit(...parameters):
	var sig = out_node.get(out_signal)

	if sig is Signal:
		sig.emit(parameters)
