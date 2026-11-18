class_name TurnBasedEnemy extends TurnBasedEntity

const MOBS = preload("res://db/registries/mobs.tres")
const MOVES = preload("res://db/registries/moves.tres")


func act(entities: Array[TurnBasedEntity]):
	var moves := MOVES as MoveRegistry
	var enemy: TurnBasedEntity = entities.pick_random()
	if enemy == null:
		return
	await on_turn_ended
	moves.typed_load_entry(ai.blackboard.get_var(&"move")).inflict(enemy.data)
	enemy.shaker.play_shake()
	await enemy.shaker.shake_finished
