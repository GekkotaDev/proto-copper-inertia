class_name SetEncounter extends FieldEncounter

@export var encounter: EncounterSet


func trigger() -> Error:
	return OK


func select_set() -> EncounterSet:
	return encounter
