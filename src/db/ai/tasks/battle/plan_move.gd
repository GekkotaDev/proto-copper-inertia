extends BTAction

@export var targets: BBArray

@export var move: MobMove

var weight: float
var target: MobData


func _enter() -> void:
	target = (targets.get_value(scene_root, blackboard) as Array[MobData]).pick_random()


func _tick(_delta: float) -> Status:
	move.plan(target)
	weight = move.weight

	return RUNNING if weight == 0 else SUCCESS if weight > 0 else FAILURE
