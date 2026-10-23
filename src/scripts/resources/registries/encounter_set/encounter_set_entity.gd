class_name EncounterSet extends Resource

@export var behavior_tree: BehaviorTree
@export var entities: Array[StringName]

func foo():
	var player := BTPlayer.new()
	player.update_mode = player.UpdateMode.MANUAL
	
	while player.update()
