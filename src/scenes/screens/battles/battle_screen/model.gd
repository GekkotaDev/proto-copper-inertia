extends V.Model

@export var mobs: Array[MobData]

@export_group("Teams", "team_")
@export var team_good: StringName
@export var team_bad: StringName
