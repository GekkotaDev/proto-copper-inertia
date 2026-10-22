extends Node

@export var file_path: Path
@export var defaults: Array[ConfigSection]

@export_group("Options")
@export var ui_group: String

var config := ConfigFile.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !FileAccess.file_exists(file_path.as_user()):
		for section in defaults:
			section.apply(config)
		config.save(file_path.as_user())
	else:
		config.load(file_path.as_user())


func autocast_ui():
	var nodes := get_tree().get_nodes_in_group(ui_group)
	for node in nodes:
		var persister := SettingsControl.new()
		var node_section = node.get_meta("settings-section")
		var node_key = node.get_meta("settings-key")
		var node_property = node.get_meta("node-property")

		if node_section == null:
			continue
		if node_key == null:
			continue
		if node_property == null:
			continue

		persister.settings_section = node_section
		persister.settings_key = node_key
		persister.control_key = node_property
		persister.control_node = node
		node.add_child(persister)
	hydrate_ui()
	return self


func hydrate_ui():
	var nodes := get_tree().current_scene.find_children("*", "SettingsControl")

	for node in nodes:
		if node is SettingsControl:
			node.hydrate(config)
	return self


func persist_ui():
	var nodes := get_tree().current_scene.find_children("*", "SettingsControl")

	for node in nodes:
		if node is SettingsControl:
			node.apply(config)

	config.save(file_path.as_user())
	return self
