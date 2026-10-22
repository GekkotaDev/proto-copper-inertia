extends Node

@export var managers: Dictionary[StringName, SceneManager] = { }

var global: SceneManager:
	get: return managers[&"global"]
