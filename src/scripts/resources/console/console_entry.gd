@abstract
class_name ConsoleEntry extends Node

@export_multiline var description: String = ""

@onready var entry_name := name.to_snake_case()
