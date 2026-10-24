# ! ! !   R E A D   N O T E S   ! ! !
class_name TurnBasedRotation extends Node3D

signal on_victory
signal victory

# A RandomEncounter or SetEncounter reusable node populates the entities array.
#
# It should not be modified within the _process. Define any logic that removes any entities within
# the filter_deck() function that instead removes it from the deck.
var entities: Array[TurnBasedEntity] = []
var entities_deck: Array[TurnBasedEntity] = []:
	get:
		return entities_deck

#  TODO
# *
# * [ ] Implement FieldEncounter nodes and its respective subclasses
# *   [ ] RandomEncounter: array of resources with weighted enemy table
# *   [ ] SetEncounter: says it on the tin
# * [ ] Animations
# * [ ] Player does not need behavior tree, just await until they've selected option.
# * [ ] Make sure it doesn't get stuck awaiting
# *
#! NO AI

# * NOTE: Do C# physics when more lucid.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	map_deck()
	filter_deck()
	#! Check if player dies or not, separate arrays per party. There's only two in battle as I can't
	#! foresee there being background characters in battle.
	if entities_deck.is_empty():
		on_victory.emit()
		victory.emit()
		return
	var entity: TurnBasedEntity = entities_deck.pop_back()
	await entity.on_turn_ended


func map_deck():
	if entities_deck.is_empty():
		entities_deck = entities.duplicate()


func filter_deck():
	pass

#! Do check entity.gd
