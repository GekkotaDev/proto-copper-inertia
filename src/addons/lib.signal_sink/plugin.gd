@tool
extends EditorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	add_autoload_singleton(&"EventBus", "res://addons/lib.signal_sink/scenes/event_bus.tscn")


func _disable_plugin() -> void:
	# Remove autoloads here.
	remove_autoload_singleton(&"EventBus")


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
