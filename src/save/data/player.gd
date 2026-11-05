## Save file containing player data.
##
## This assumes the absence of a party system and only a single player. This can be adapted to work
## with a party system if necessary albeit you'll have to split this file.

@tool
extends Resource

@export var inventory: Dictionary

@export_group("Stats")
@export var health: Vector2i
@export var speed: Vector2i
@export var defense: Vector2i
@export var attack: Vector2i


static func _static_init() -> void:
	if Engine.is_editor_hint():
		WCSafeResourceFormatSettings.allow()
