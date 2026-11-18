@tool
class_name MoveRegistry extends TypedRegistry


func typed_load_all_blocking() -> Dictionary[StringName, MobMove]:
	return load_all_blocking() as Dictionary[StringName, MobMove]


func typed_load_entries(ids: Array[StringName]) -> Dictionary[StringName, MobMove]:
	return load_entries(ids)


func typed_load_entry(
	id: StringName,
	type_hint: String = "",
	cache_mode: ResourceLoader.CacheMode = ResourceLoader.CacheMode.CACHE_MODE_REUSE,
) -> MobMove:
	return load_entry(id, type_hint, cache_mode)
