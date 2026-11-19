extends BTAction


func _tick(delta: float) -> Status:
	if agent is TurnBasedEntity:
		agent.turn_ended.emit()
		agent.ai.active = false

	return SUCCESS
