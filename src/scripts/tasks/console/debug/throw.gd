extends ConsoleCommand


func command() -> void:
	Console.throw(OK, get_stack(), "Test error")


func autocomplete() -> Array[AutocompleteSource]:
	return []
