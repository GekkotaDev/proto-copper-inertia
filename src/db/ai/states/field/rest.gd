extends LimboState

# @export var resting_point: Marker3D

# @export_group("Alert")
# @export var alert_area: Area3D
# @export var alert_groups: Array[StringName] = []

# #* Body
# @onready var body: CharacterBody3D = blackboard.get_var(&"parent")
# @onready var speed: float = blackboard.get_var(&"speed")

# #* Navigation
# @onready var navigation_agent: NavigationAgent3D = blackboard.get_var(&"navigation_agent")

# var sleeping := false
# var alert_poll := SignalPoll.new(alert_area.body_entered)

# func _enter() -> void:
# 	pass

# func _update(delta: float) -> void:
# 	if alert_poll.fired:
# 		var detected: Node3D = alert_poll.parameters[0]

# 		if alert_groups.any(
# 			func(group: String):
# 				return detected.is_in_group(group),
# 		):
# 			dispatch()
# 		body.move_and_slide()
# 		return

# 	if navigation_agent.is_navigation_finished():
# 		body.velocity = Vector3.ZERO

# 		body.move_and_slide()
# 		return

# func _exit() -> void:
# 	pass
