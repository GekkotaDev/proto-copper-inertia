@abstract
class_name MobAttribute extends Resource

## Scope of the property.
@export var key: StringName
@export var value: Variant:
	get:
		return get_value()
	set(data):
		var result := set_value(data)
		if result != OK:
			return
		value = data


## Type safe property accessor.
@abstract
func get_value()


@abstract
func set_value(data: Variant) -> Error
