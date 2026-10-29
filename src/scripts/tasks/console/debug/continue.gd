extends ConsoleCommand


func command() -> void:
	if not get_tree().paused:
		LimboConsole.info("Game already resumed")
		return
	get_tree().paused = false
	LimboConsole.info("Resumed")


func autocomplete() -> Array[AutocompleteSource]:
	return []
