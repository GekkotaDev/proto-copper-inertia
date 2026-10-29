extends ConsoleCommand


func command() -> void:
	Console.warn("Developer Console smoke test.")


func autocomplete() -> Array[AutocompleteSource]:
	return []
