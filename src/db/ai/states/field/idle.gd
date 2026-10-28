extends LimboState

@export_group("Alert")
@export var alert_area: Area3D
@export var alert_groups: Array[StringName] = []

#* Body
@onready var body: CharacterBody3D = blackboard.get_var(&"parent")
@onready var speed: float = blackboard.get_var(&"speed")

#* Navigation
@onready var navigation_agent: NavigationAgent3D = blackboard.get_var(&"navigation_agent")
@onready var path: Path3D = blackboard.get_var(&"path")
@onready var timeout: Vector2 = blackboard.get_var(&"timeout")

var timer := Timer.new()

var timer_poll := TimerPoll.new(timer)
var alert_poll := SignalPoll.new(alert_area.body_entered)

var points_positions: Array[Vector3]:
	get:
		var curve := path.curve
		var positions: Array[Vector3] = []
		var count := curve.point_count

		for index in range(count):
			var property := "point_{index}/position".format({ index = index })
			positions.append(curve.get(property))
		return positions

var lower_bounds := Vector2.ZERO
var upper_bounds := Vector2.ZERO
var target_position := Vector3.ZERO


func renew_target_position() -> Vector3:
	return Vector3(
		randf_range(lower_bounds.x, lower_bounds.y),
		path.position.y,
		randf_range(upper_bounds.x, upper_bounds.y),
	)


func _enter() -> void:
	lower_bounds = points_positions.reduce(
		func(lowest: Vector3, point: Vector3) -> Vector3:
			return lowest if lowest < point else point,
	)

	upper_bounds = points_positions.reduce(
		func(highest: Vector3, point: Vector3) -> Vector3:
			return highest if highest > point else point,
	)

	target_position = renew_target_position()
	timer.start(randf_range(timeout.x, timeout.y))


func _update(_delta: float) -> void:
	if alert_poll.fired:
		var detected: Node3D = alert_poll.parameters[0]

		if alert_groups.any(
			func(group: String):
				return detected.is_in_group(group),
		):
			dispatch()
		body.move_and_slide()
		return

	if timer_poll.is_active:
		body.move_and_slide()
		return

	if navigation_agent.is_navigation_finished():
		target_position = renew_target_position()
		body.velocity = Vector3.ZERO

		timer.start(randf_range(timeout.x, timeout.y))

		body.move_and_slide()
		return

	navigation_agent.target_position = target_position

	var next_path_position := navigation_agent.get_next_path_position()
	var direction := body.global_position.direction_to(next_path_position)

	body.velocity = direction * speed
	body.move_and_slide()


func _exit() -> void:
	pass
