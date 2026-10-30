class_name BattleScene extends Scene

# @export_category("")
@export var template := TreeTemplate.new()
@export var opponents: Array[MobData] = []


func _start(data: Variant):
	assert(
		DictionaryTools
		.Validate
		.parse(
			data,
			{
				opponents = func(nodes: Variant):
					return nodes is Array[MobData], #
			},
		)
	)

	if data is Dictionary[String, Variant]:
		opponents = data.get("opponents", [])


func _ready() -> void:
	template.bind(self)

	for index in range(3):
		template.add_child(&"mob", opponents[index].battle_scene.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
