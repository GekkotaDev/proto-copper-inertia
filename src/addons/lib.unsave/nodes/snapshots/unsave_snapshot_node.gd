@tool

@abstract
class_name UnsaveSnapshotNode extends UnsaveSnapshot

@export var parent: Node


func _ready() -> void:
	parent = get_parent()
