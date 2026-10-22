extends Scene

@export var manager: StringName = &"global"
@export var next_scene: StringName


var read := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		return
	if event is InputEventJoypadMotion:
		return
	
	if read:
		return
	read = true
	
	var scene_manager := MultiSceneManager.managers[manager]
	scene_manager.queue_set_scene(next_scene)
	scene_manager.apply()
