class_name BattleScene extends Scene

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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
