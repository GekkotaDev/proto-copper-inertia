class_name MobStatus extends MobMove

@export var lifetime: int = -1

var is_live: bool:
	get:
		return lifetime > 0


func inflict(mob: MobData):
	if is_live:
		super(mob)
	return ERR_UNAUTHORIZED
