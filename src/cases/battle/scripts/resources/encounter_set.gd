class_name EncounterSet extends Resource

@export var condition: BehaviorTree
@export var entities: Array[StringName]
@export_group("Amount")
@export var amount: int:
	get:
		return randi_range(lower_bounds, upper_bounds)
@export var lower_bounds: int:
	get:
		return lower_bounds if lower_bounds > 0 else 0
	set(value):
		lower_bounds = value
@export var upper_bounds: int


func query_entity_ids() -> Array[StringName]:
	return range(amount).map(
		func():
			return entities.pick_random(),
	)


func wait_condition() -> BTTask.Status:
	var sentinel_blackboard := Blackboard.new()
	var sentinel_node := Node.new()
	var behavior_tree := condition.instantiate(sentinel_node, sentinel_blackboard, sentinel_node)
	var state := BTTask.FRESH

	while behavior_tree.update(NAN) in [BTTask.RUNNING, BTTask.FRESH]:
		state = behavior_tree.get_last_status()

	return state


func is_success() -> bool:
	return wait_condition() == BTTask.SUCCESS


func is_failure() -> bool:
	return wait_condition() == BTTask.FAILURE
