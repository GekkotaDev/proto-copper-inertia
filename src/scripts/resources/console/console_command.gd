@icon("res://addons/at-icons/node/window_terminal.svg")

@abstract
class_name ConsoleCommand extends ConsoleEntry


class AutocompleteSource:
	var argument_index: int
	var completer: Callable


	func _init(index: int) -> void:
		argument_index = index


	func maps_to(callback: Callable):
		completer = callback


@export var register: bool = true

var subcommands: Array[ConsoleCommand] = []


func _ready() -> void:
	for node in get_children():
		if node is ConsoleCommand:
			subcommands.append(node)

	for subcommand in subcommands:
		subcommand.entry_name = "{command} {subcommand}".format(
			{ command = entry_name, subcommand = subcommand.entry_name }
		)


@abstract
func command() -> void


@abstract
func autocomplete() -> Array[AutocompleteSource]
