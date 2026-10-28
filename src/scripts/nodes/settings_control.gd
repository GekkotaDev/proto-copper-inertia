@icon("res://addons/at-icons/control/cog.svg")
class_name SettingsControl extends Node

@export_group("Settings")
@export var settings_section: StringName
@export var settings_key: StringName

@export_group("UI")
@export var control_node: Control
@export var control_key: StringName

var settings_value:
	get:
		return control_node.get(control_key)


func _ready() -> void:
	control_node = control_node if control_node != null else get_parent()


func apply(config: ConfigFile):
	config.set_value(settings_section, settings_key, settings_value)


func hydrate(config: ConfigFile):
	var value = config.get_value(settings_section, settings_key)
	control_node.set(control_key, value)
