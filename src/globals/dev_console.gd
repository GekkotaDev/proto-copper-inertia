@icon("res://addons/at-icons/node/window_terminal.svg")
extends Node

var subcommands: Array[ConsoleCommand] = []


func throw(code: Error, stack: Array[Dictionary], message: String):
	get_tree().paused = true
	LimboConsole.warn("PAUSED!")

	print()

	LimboConsole.error("{code}: {message}".format({ code = error_string(code), message = message }))
	Log.error("{code}: {message}".format({ code = error_string(code), message = message }))

	var stack_trace := stack

	LimboConsole.print_line("STACK TRACE")
	Log.info("STACK TRACE")

	for index in range(stack_trace.size()):
		var called: Dictionary = stack_trace[index]
		var file: String = called["source"]
		var function: String = called["function"]
		var line: int = called["line"]
		var trace_line := '{index}: File "{file} at line {line}, function {function}"'.format(
			{ index = index, file = file, line = line, function = function }
		)

		print(trace_line)
		LimboConsole.print_line(trace_line)

	print()


func info(message: String):
	Log.info.call(message)
	LimboConsole.info.call(message)


func warn(message: String):
	Log.warn.call(message)
	LimboConsole.warn.call(message)


func error(message: String):
	Log.error.call(message)
	LimboConsole.error.call(message)


func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_children():
		if node is ConsoleCommand:
			subcommands.append(node)
	_register_commands(subcommands)
	Log.info("Developer console initialized")


func _register_commands(commands: Array[ConsoleCommand]):
	var queue: Array[ConsoleCommand] = []
	# ProjectSettings.get_setting("")
	for command in commands:
		queue.append_array(command.subcommands)

		if not command.register:
			continue

		LimboConsole.register_command(command.command, command.entry_name, command.description)
		for completer in command.autocomplete():
			LimboConsole.add_argument_autocomplete_source(
				command.entry_name,
				completer.argument_index,
				completer.completer,
			)

	if not queue.is_empty():
		_register_commands(queue)
