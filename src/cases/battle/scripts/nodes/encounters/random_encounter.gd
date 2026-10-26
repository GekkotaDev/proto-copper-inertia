class_name RandomEncounter extends FieldEncounter

@export var sets: Array[EncounterSet] = []


func trigger() -> Error:
	return OK


func select_set() -> EncounterSet:
	var shuffled_set: Array[EncounterSet] = sets.duplicate()
	shuffled_set.shuffle()

	for encounter_set in shuffled_set:
		if encounter_set.is_failure():
			continue
		return encounter_set
	return null
