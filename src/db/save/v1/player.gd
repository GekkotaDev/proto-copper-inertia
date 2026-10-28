@tool
extends Resource

@export var health: float


static func _static_init() -> void:
	if Engine.is_editor_hint():
		WCSafeResourceFormatSettings.allow()
