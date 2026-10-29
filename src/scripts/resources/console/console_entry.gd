@abstract
class_name ConsoleEntry extends Node

@onready var entry_name := name.to_snake_case()
@export_multiline var description: String = ""
