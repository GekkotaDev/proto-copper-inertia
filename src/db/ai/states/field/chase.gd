extends LimboState

@export_group("Chase")
@export var chase_area: Area3D
@export var chase_groups: Array[StringName] = []

#* Body
@onready var body: CharacterBody3D = blackboard.get_var(&"parent")
@onready var speed: float = blackboard.get_var(&"speed")

#* Navigation
@onready var navigation_agent: NavigationAgent3D = blackboard.get_var(&"navigation_agent")
@onready var target: Node3D = blackboard.get_var(&"path")

var chase_poll := SignalPoll.new(chase_area.body_exited)


func _update(delta: float) -> void:
	if chase_poll.fired:
		var detected: Node3D = chase_poll.parameters[0]

		if chase_groups.any(
			func(group: String):
				return detected.is_in_group(group),
		):
			dispatch()
		body.move_and_slide()
		return

	if target == null:
		body.move_and_slide()
		return

	if navigation_agent.is_navigation_finished():
		body.velocity = Vector3.ZERO
		body.move_and_slide()
		dispatch()
		return

	navigation_agent.target_position = target.global_position

	var next_path_position := navigation_agent.get_next_path_position()
	var direction := body.global_position.direction_to(next_path_position)

	body.velocity = direction * speed
	body.move_and_slide()
