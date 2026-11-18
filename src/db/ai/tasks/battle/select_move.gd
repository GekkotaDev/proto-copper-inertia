extends BTComposite

const BTPlanMove := preload("res://db/ai/tasks/battle/plan_move.gd")

@export var targeter: MobTarget

var _tasks: Array[BTPlanMove]:
	get:
		var arr: Array[BTPlanMove] = []

		for index in range(get_child_count()):
			var child := get_child(index)

			if child is BTPlanMove:
				arr.append(child)

		return arr

var move: MobMove
var target: MobData


func _enter() -> void:
	var mobs: Array[MobData] = scene_root \
			.get_nodes_in_group(&"battler") \
			.filter(
		func(node: Node):
			return node is TurnBasedEntity,
	) \
			.map(
		func(entity: TurnBasedEntity):
			return entity.data,
	)

	get_child(0).blackboard.set_var(&"targets", targeter.locate(mobs))


func _tick(_delta: float) -> Status:
	var tasks: Array[BTPlanMove] = _tasks.duplicate()
	tasks.sort_custom(
		func(a: BTPlanMove, b: BTPlanMove):
			return a.weight > b.weight,
	)
	tasks = tasks.filter(
		func(task: BTPlanMove):
			return task.status == SUCCESS,
	)

	if tasks.is_empty():
		return FAILURE

	tasks[0].move.inflict(tasks[0].target)
	return SUCCESS
