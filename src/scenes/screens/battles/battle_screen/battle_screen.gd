class_name BattleScene extends Scene

const Model = preload("uid://x3cej701i1ny")

@export var model := preload("res://scenes/screens/battles/battle_screen/model.tres")

# @export_category("")
@export var dialogue: DialogueResource
@export var template := TreeTemplate.new()
@export var opponents: Array[MobData] = []


func _start(data: Variant):
	model.mobs = data.get(&"mobs")


func _ready() -> void:
	Log.info(opponents.size())
	for index in range(3):
		if index > opponents.size() - 1:
			break
		template.add_child(&"mob", opponents[index].battle_scene.instantiate())

	DialogueManager.show_dialogue_balloon(dialogue)
