@tool
class_name MobRegistry extends TypedRegistry


func typed_load_all_blocking() -> Dictionary[StringName, MobData]:
	return load_all_blocking() as Dictionary[StringName, MobData]


func typed_load_entries(ids: Array[StringName]) -> Dictionary[StringName, MobData]:
	return load_entries(ids)


func typed_load_entry(
	id: StringName,
	type_hint: String = "",
	cache_mode: ResourceLoader.CacheMode = ResourceLoader.CacheMode.CACHE_MODE_REUSE,
) -> MobData:
	return load_entry(id, type_hint, cache_mode)
