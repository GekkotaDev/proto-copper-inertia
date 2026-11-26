@icon("res://addons/at-icons/node/floppy_disk.svg")

@abstract
class_name UnsaveSlot extends Resource

const UnsaveSlot = preload("./unsave_slot.gd")

@export var version: Vector2i

var save_flags := ResourceSaver.FLAG_BUNDLE_RESOURCES + ResourceSaver.FLAG_COMPRESS


func default(key: StringName, factory_or_value: Variant):
	if factory_or_value is Callable:
		set(key, factory_or_value.call())
	set(key, factory_or_value)
	return self


@abstract
func migrate(slot: UnsaveSlot) -> UnsaveSlot
