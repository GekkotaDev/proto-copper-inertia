@icon("res://addons/goactions/icons/go_action_caller.svg")

@tool
extends GoAction


@export_group("In", "in_")
@export var in_node: Node:
	get:
		return in_node
	set(value):
		in_node = value
		notify_property_list_changed()

@export_group("Out", "out_")
@export var out_parameters: Array[Variant] = []:
	get:
		return out_parameters
	set(value):
		if in_node == null:
			return

		var old := out_parameters
		out_parameters = value

		if old.size() == value.size():
			return

		if _vararg_methods.has(out_function):
			return

		out_parameters.resize(in_node.get_method_argument_count(out_function) + 1)
		notify_property_list_changed()


@export var out_function: String:
	get:
		return out_function
	set(value):
		if in_node == null:
			return

		out_function = value


var _vararg_methods: Array[StringName] = []


func _validate_property(property: Dictionary) -> void:
	_vararg_methods.clear()
	for method in in_node.get_method_list():
		var is_vararg := bool(method["flags"] & METHOD_FLAG_VARARG)
		if is_vararg:
			_vararg_methods.append(method["name"])

	if property.name == "out_function":
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(
			in_node.get_script().get_script_method_list() \
				.map(func(method): return method["name"]) \
				.filter(
					func(method: StringName):
						return not method.begins_with(&"get_") and not method.begins_with(&"set_")
						,
				)
		)


func _trigger() -> void:
	in_node.get(out_function).callv(out_parameters)
