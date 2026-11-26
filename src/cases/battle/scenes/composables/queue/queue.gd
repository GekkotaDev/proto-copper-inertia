@icon("res://addons/at-icons/node/arrows_clockwise.svg")
class_name TurnBasedQueue extends Node

signal victory(team: StringName)

@export var party: Array[MobData] = []
@export_group("Teams", "team_")
@export var team_good: StringName
@export var team_bad: StringName
@export_range(1, 3) var team_limit: int = 3

var party_waitlist: Array[MobData] = []
var party_members: Array[TurnBasedEntity] = []
var party_queue: Array[TurnBasedEntity] = []
var next_member: TurnBasedEntity

var teams: Array[StringName]:
	get:
		var list: Array[StringName] = []

		for member in party:
			if member.team in list:
				continue
			list.append(member.team)

		return list


func _ready() -> void:
	for member in party:
		party_waitlist.append(member.battle_scene.instantiate())

	var new_waitlist: Array[MobData] = []
	for member in party_waitlist:
		if member.team == team_good:
			party_members.append(member)
			continue

		if member.team == team_bad and team_size_of(team_bad) <= team_limit:
			party_members.append(member)
			continue

		if member.team == team_bad:
			new_waitlist.append(member)
			continue
	party_waitlist = new_waitlist


func has_team_lost(team: StringName):
	return party_members \
		.filter(
			func(member: TurnBasedEntity):
				return member.is_in_group(team)
				,
		) \
		.size() <= 0


func next():
	var members: Array[TurnBasedEntity] = []
	for member in party_members:
		var health := member.data.attributes[&"health"]

		if health == null:
			continue

		if health.value <= 0:
			continue

		members.append(member)
	party_members = members
	return next_entity()


func next_entity():
	var new_waitlist: Array[MobData] = []
	for member in party_waitlist:
		if member.team == team_bad and team_size_of(team_bad) <= team_limit:
			party_members.append(member)
			continue

		if member.team == team_bad:
			new_waitlist.append(member)
			continue
	party_waitlist = new_waitlist

	if party_queue.is_empty():
		party_queue = party_members.duplicate()

	next_member = party_queue.pop_front()
	return next_member


func team_of(team: StringName):
	return party_members \
		.filter(
			func(member: TurnBasedEntity):
				return member.is_in_group(team)
				,
		)


func team_size_of(team: StringName):
	return team_of(team).size()
