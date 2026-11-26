@icon("res://addons/at-icons/animation/clapperboard.svg")

@tool
class_name GoChangeScene extends GoAction

@export var scene: PackedScene
@export var options: Dictionary[StringName, Variant] = {}

@export_group("Callables", "on_")
@export var on_tree_enter: GDScript
@export var on_ready: GDScript
@export var on_fade_out: GDScript
@export var on_fade_in: GDScript


func _trigger() -> void:
	var noop := func(...__): pass
	var opts := options.duplicate()

	opts[&"on_tree_enter"] = (func(node): on_tree_enter.new(node)) if on_tree_enter else noop
	opts[&"on_ready"] = (func(node): on_ready.new(node)) if on_ready else noop
	opts[&"on_fade_out"] = (func(): on_fade_out.new()) if on_fade_out else noop
	opts[&"on_fade_in"] = (func(): on_fade_in.new()) if on_fade_in else noop

	SceneManager.change_scene(scene, opts)
