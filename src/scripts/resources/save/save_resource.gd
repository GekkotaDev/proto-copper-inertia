@tool
class_name SaveResource extends Resource


class Of:
	pass


@export var version: Vector3i


static func _static_init() -> void:
	if Engine.is_editor_hint():
		WCSafeResourceFormatSettings.allow()


static func load():
	pass
