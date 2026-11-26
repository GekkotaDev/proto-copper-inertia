class_name AIDataWeights extends Resource


static var path := "user://ml/weights.tscn"
static var instance: AIDataWeights

static func instantiate() -> AIDataWeights:
	if instance == null:
		instance = new()
	return instance

@export var moves: Dictionary[String, float] = {}


func _init() -> void:
	var cache: AIDataWeights = self

	if FileAccess.file_exists(path):
		cache = ResourceLoader.load(path)
	moves = cache.moves


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_PREDELETE:
			ResourceSaver.save(self, path)
