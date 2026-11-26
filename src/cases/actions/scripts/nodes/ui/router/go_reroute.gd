@icon("res://addons/at-icons/animation/itinerary.svg")

@tool
class_name GoReroute extends GoAction


@export_tool_button("Update Values", "Callable") var update := _update_values

@export var route: StringName:
	get:
		return route
	set(value):
		if router:
			route = value
@export var router: MenuRouter:
	get:
		return router
	set(value):
		router = value
		notify_property_list_changed()

@export_group("From", "from_")
@export var from_name: StringName:
	get:
		return from_name
	set(value):
		if from_transition:
			from_name = value
@export var from_transition: JuiceePlayer:
	get:
		return from_transition
	set(value):
		from_transition = value
		notify_property_list_changed()

@export_group("To", "to_")
@export var to_name: StringName:
	get:
		return to_name
	set(value):
		if to_transition:
			to_name = value
@export var to_transition: JuiceePlayer:
	get:
		return to_transition
	set(value):
		to_transition = value
		notify_property_list_changed()


func _update_values():
	notify_property_list_changed()


func _trigger() -> void:
	from_transition.play(from_name)
	await from_transition.finished

	to_transition.play(to_name)
	router.go_to(route)
	await to_transition.finished


func _validate_property(property: Dictionary) -> void:
	if property.name == "to_name" and to_transition != null:
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(
			from_transition.sequences \
				.map(func(res: JuiceeSequence): return res.resource_name)
		)
	
	if property.name == "from_name" and from_transition != null:
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(
			to_transition.sequences \
				.map(func(res: JuiceeSequence): return res.resource_name)
		)

	if property.name == "route" and router != null:
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(
			router.get_children() \
				.filter(func(node: Node): return node is MenuContainer) \
				.map(func(menu: MenuContainer): return menu.name)
		)
