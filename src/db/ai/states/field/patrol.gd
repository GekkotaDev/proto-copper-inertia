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

var current_point_index: int = 0:
	get:
		return current_point_index
	set(value):
		if value >= path.curve.point_count:
			current_point_index = 0

var target_position := Vector3.ZERO


func _enter() -> void:
	target_position = points_positions[current_point_index]
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
		current_point_index += 1
		target_position = points_positions[current_point_index]
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
