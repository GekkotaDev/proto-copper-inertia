class_name MobMove extends Resource

@export var behavior: GDScript


func inflict(mob: MobData):
	var script = behavior.new()

	if script is MobEffect:
		return script.inflict(mob)

	return ERR_SCRIPT_FAILED
