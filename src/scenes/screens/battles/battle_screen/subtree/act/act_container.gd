extends PanelContainer

const Model = preload("uid://x3cej701i1ny")

@export var model: Model

@export_group("UI")
@export var root: Control
@export var gesture: Gesture
@export var reducer: VisibilityReducer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	# V.view.each(
	# 	#
	# 	model,
	# 	&"mobs",
	# 	&"rid",
	# 	root,
	# 	func(mob: MobData, index: int):
	# 		var button := Button.new()

	# 		button.name = "Button{index}".format({ index = index })
	# 		button.text = mob.name
	# 		button.pressed.connect(
	# 			func():
	# 				reducer.dispatch("null")
	# 				gesture.classify()
	# 				var result = await gesture.gesture_name
	# 				var gesture_name = result[0]
	# 				var percentage = result[1],
	# 		)

	# 		return button,
	# )
