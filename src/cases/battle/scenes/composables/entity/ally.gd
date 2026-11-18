class_name TurnBasedAlly extends TurnBasedEntity

const MOBS = preload("res://db/registries/mobs.tres")
const MOVES = preload("res://db/registries/moves.tres")


func act(entities: Array[TurnBasedEntity]):
	var gesture_nodes := get_tree().current_scene.find_children("*", "Gesture")
	var viewport_nodes := get_tree().current_scene.find_children("ViewportRoot", "Control")

	var gesturizer: Gesture
	var viewport: Control

	for node in gesture_nodes:
		if node is Gesture:
			gesturizer = node
			break

	for node in viewport_nodes:
		if node is Control:
			viewport = node
			break

	viewport.visible = false
	await gesturizer.on_draw_exit
	gesturizer.classify()
	var result = await gesturizer.gesture_name
	var gesture_name: StringName = result[0]
	viewport.visible = true

	var moves := MOVES as MoveRegistry
	var enemy: TurnBasedEntity = entities.pick_random()
	if enemy == null:
		return
	moves.typed_load_entry(gesture_name).inflict(enemy.data)
	enemy.shaker.play_shake()
	await enemy.shaker.shake_finished


func use():
	pass
