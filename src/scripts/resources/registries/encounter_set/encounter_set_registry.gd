@tool
class_name EncounterSetRegistry extends TypedRegistry


func typed_load_all_blocking() -> Dictionary[StringName, EncounterSet]:
	return load_all_blocking() as Dictionary[StringName, EncounterSet]


func typed_load_entries(ids: Array[StringName]) -> Dictionary[StringName, EncounterSet]:
	return load_entries(ids)


func typed_load_entry(id: StringName) -> EncounterSet:
	return load_entry(id)
