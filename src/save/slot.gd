@tool
class_name SaveSlot extends UnsaveSlot

const Player := preload("res://save/data/player.gd")
const Snapshot := preload("res://save/data/snapshot.gd")

@export var player: Player
@export var snapshot: Snapshot


func migrate(_slot: UnsaveSlot) -> UnsaveSlot:
	return self


static func _static_init() -> void:
	if Engine.is_editor_hint():
		WCSafeResourceFormatSettings.allow()


func _init() -> void:
	default(
		&"player",
		func():
			return Player.new(),
	)

	default(
		&"snapshot",
		func():
			return Snapshot.new(),
	)
