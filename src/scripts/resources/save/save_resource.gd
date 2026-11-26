@tool
class_name SaveResource extends Resource

@export var version: Vector3i


static func _static_init() -> void:
	if Engine.is_editor_hint():
		WCSafeResourceFormatSettings.allow()


static func load():
	pass


class Of:
	pass
