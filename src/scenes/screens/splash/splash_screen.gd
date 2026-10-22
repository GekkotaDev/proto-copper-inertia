extends Control

@export var player: AnimationPlayer


func _ready():
	player.play(&"splash")
	player.animation_finished.connect(next_scene)


func next_scene(animation_name: StringName):
	if not animation_name.contains("splash"):
		return
	
	MultiSceneManager.global.queue_set_scene(&"Main Menu")
	MultiSceneManager.global.apply()
