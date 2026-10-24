@tool
class_name EncounterEntityRegistry extends TypedRegistry


func typed_load_all_blocking() -> Dictionary[StringName, EncounterEntity]:
	return load_all_blocking() as Dictionary[StringName, EncounterEntity]


func typed_load_entries(ids: Array[StringName]) -> Dictionary[StringName, EncounterEntity]:
	return load_entries(ids)


func typed_load_entry(
	id: StringName,
	type_hint: String = "",
	cache_mode: ResourceLoader.CacheMode = ResourceLoader.CacheMode.CACHE_MODE_REUSE,
) -> EncounterEntity:
	return load_entry(id, type_hint, cache_mode)
