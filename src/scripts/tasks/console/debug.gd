extends ConsoleCommand


func _init() -> void:
	register = false


func command() -> void:
	pass


func autocomplete() -> Array[AutocompleteSource]:
	return []
