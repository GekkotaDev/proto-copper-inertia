class_name MobMove extends Resource

@export var weight: int
@export var behavior: GDScript


func inflict(mob: MobData):
	var script = behavior.new()

	if script is MobEffect:
		script.inflict(mob)
		mob.emit_changed()
		return 1

	return NAN


func plan(mob: MobData):
	var script = behavior.new()

	if script is MobEffect:
		weight = script.inflict(mob.duplicate_deep())
