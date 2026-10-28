@icon("res://addons/at-icons/node2d/arrow_axes.svg")

@abstract
class_name SpawnerTransform2D extends Node

@export var spawner: Spawner2D


@abstract
func transform_node(node: Node2D, offset: Transform2D = Transform2D.IDENTITY) -> Node2D
