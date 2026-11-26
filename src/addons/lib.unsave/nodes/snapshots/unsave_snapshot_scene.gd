@abstract
class_name UnsaveSnapshotScene extends UnsaveSnapshot

@export var root: Node


func _ready() -> void:
	root = root if root else get_tree().current_scene


func to_packed_scene():
	var packed_scene := PackedScene.new()
	var result := packed_scene.pack(root)
	return packed_scene
