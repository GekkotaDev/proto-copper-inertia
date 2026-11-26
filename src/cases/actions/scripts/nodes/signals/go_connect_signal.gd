@tool
class_name GoConnectSignal extends GoAction

@export var action: GoAction

@export_group("In", "in_")
@export var in_signal: String = ""
@export var in_node: Node:
	get:
		return in_node
	set(value):
		in_node = value
		notify_property_list_changed()


func _validate_property(property: Dictionary) -> void:
	if property.name == "in_signal":
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(
			in_node.get_signal_list().map(func(sig): return sig["name"])
		)


func _ready() -> void:
	var sig = in_node.get(in_signal)

	if sig is Signal:
		sig.connect(
			func(...__):
				action.trigger()
		)
