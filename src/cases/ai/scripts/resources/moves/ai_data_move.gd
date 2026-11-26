@abstract
class_name AIDataMove extends Resource

signal message

@export_group("Persistence", "persisted_")
@export var persisted_id: String = resource_name
@export var persisted_weight: float = 0.0

var targets: Array[AIExecAgent] = []

var is_animating := false

var is_null_target: bool:
	get:
		return targets.size() <= 0

var is_single_target: bool:
	get:
		return targets.size() == 1

var _step := 0


func _init() -> void:
	var weights := AIDataWeights.instantiate()
	persisted_weight = weights.moves[persisted_id]


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			var weights := AIDataWeights.instantiate()
			weights.moves[persisted_id] = persisted_weight


@abstract
func query_targets(world: AIExecWorld) -> BT.Status


@abstract
func query_conditions(world: AIExecWorld, agent: AIExecAgent) -> BT.Status


@abstract
func setup_visuals()


@abstract
func animate() -> BT.Status


@abstract
func plan() -> BT.Status


@abstract
func execute() -> BT.Status


func run(world: AIExecWorld, agent: AIExecAgent) -> BT.Status:
	if _step == 0:
		var status := query_targets(world)
		match status:
			BT.SUCCESS:
				_step = 1
			_:
				return status

	if _step == 1:
		var status := query_conditions(world, agent)
		match status:
			BT.SUCCESS:
				_step = 2
			_:
				return status

	if agent.is_planning:
		_step = 4

	if _step == 2:
		setup_visuals()
		_step = 3

	if _step == 3:
		var status := animate()
		match status:
			BT.SUCCESS:
				_step = 4
			_:
				return status

	var final_status := plan() if agent.is_planning else execute()

	if final_status != BT.RUNNING:
		_step = 0

	return final_status


func is_self_target(agent: AIExecAgent):
	if is_null_target:
		return false

	if not is_single_target:
		return false

	return targets[0] == agent
