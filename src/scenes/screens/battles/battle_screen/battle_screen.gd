class_name BattleScene extends Scene

const Model = preload("uid://x3cej701i1ny")

@export var model := preload("res://scenes/screens/battles/battle_screen/model.tres")

# @export_category("")
@export var dialogue: DialogueResource
@export var mobs: Array[MobData] = []
@export var template: TreeTemplate

func _start(data: Variant):
	model.mobs = data.get(&"mobs")


func _ready() -> void:
	var entities: Array[TurnBasedEntity] = []
	for mob in mobs:
		entities.append(mob.battle_scene.instantiate())

	var opponents: Array[TurnBasedEntity] = []
	for entity in entities:
		if entity.data.team.contains(&"ai"):
			opponents.append(entity)

	for index in range(3):
		if index > opponents.size() - 1:
			break
		template.populate(
			opponents[index].battle_scene.instantiate(),
			&"{index}".format({ index = index })
		)

	for entity in entities:
		await entity.turn()
