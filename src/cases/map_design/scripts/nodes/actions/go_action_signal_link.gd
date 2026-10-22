## Call the given [GoAction]s when the connected signal has been triggered.
@tool
class_name GoActionSignalLink extends GoAction

@export var action_nodes: Array[GoAction] = []

@export_group("Node")
@export var target_node: Node:
	set(value):
		target_node = value
		update_configuration_warnings()
@export var target_signal: StringName = &""

@export_group("Options")
@export var connect_flags: Array[ConnectFlags] = []
@export var delay: float = 0.0


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array[String] = []
	
	if target_node == null:
		warnings.append("Target node must be assigned")
	
	return warnings


func _ready() -> void:
	if Engine.is_editor_hint():
		return
		
	if target_node == null:
		return
	
	var signal_ref = target_node.get(target_signal)

	if signal_ref is Signal:
		signal_ref.connect(
			_trigger,
			connect_flags.reduce(
				func(a: int, b: int):
					return a + b,
			) or 0,
		)


func _exit_tree() -> void:
	if target_node == null:
		return
		
	var signal_ref = target_node.get(target_signal)

	if signal_ref is Signal:
		signal_ref.disconnect(_trigger)


func _trigger() -> void:
	started.emit()
	await get_tree().create_timer(delay).timeout
	for action_node in action_nodes:
		action_node.trigger()
	finished.emit()
