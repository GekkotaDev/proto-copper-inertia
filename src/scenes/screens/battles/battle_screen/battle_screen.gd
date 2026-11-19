class_name BattleScene extends Scene

const MOBS = preload("res://db/registries/mobs.tres")
const MOVES = preload("res://db/registries/moves.tres")

const Model = preload("uid://x3cej701i1ny")

signal battle_ended

@export var gesturizer: Gesture
@export var model := preload("res://scenes/screens/battles/battle_screen/model.tres")
@export var opponents: Array[MobData] = []
@export var queue: TurnBasedQueue

@export_category("Dialogue")
# @export var dialogue: DialogueResource
@export var dialogue_balloon: DialogueBalloon

var template := TreeTemplate.new()

var _player: MobData


func on_battle_begin():
	pass


func on_battle_end():
	pass


func _start(data: Variant):
	model.mobs = data.get(&"mobs")


func _ready() -> void:
	on_battle_begin()
	battle_ended.connect(on_battle_end)

	gesturizer.on_draw_exit.connect(
		func():
			gesturizer.classify()
	)

	for index in range(3):
		if index > opponents.size() - 1:
			break
		var entity: TurnBasedEntity = opponents[index].battle_scene.instantiate()
		template.add_child(&"mob", entity)

	var mobs := MOBS as MobRegistry
	_player = mobs.typed_load_entry(&"player")
	
	if _player:
		queue.party.append(_player)
	queue.party.append_array(opponents)

	dialogue_balloon.start()


func start(data: Variant):
	_start(data)


func end(message: String = ""):
	battle_ended.emit()
