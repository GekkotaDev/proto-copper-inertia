const Model := preload("res://addons/lib.wireview/resources/ui_model.gd")


func each(
	#
	model: Model,
	property: StringName,
	keyable: StringName,
	parent: Node,
	builder: Callable,
):
	var unknown_value := model.get(property)

	if unknown_value is not Array:
		return

	var value: Array[Object] = unknown_value
	var diff: Array[Object] = unknown_value.duplicate()

	for index in range(value.size()):
		parent.add_child(builder.call(value[index], index))

	model.changed.connect(
		func():
			value = model.get(property)

			for index in range(value.size()):
				if value[index].get(keyable) == diff[index].get(keyable):
					continue
				var child := parent.get_child(index)
				child.replace_by(builder.call(value[index], index))
				child.queue_free()

			for index in range(parent.get_child_count()):
				if index >= value.size():
					var child := parent.get_child(index)
					parent.remove_child(child)
					child.queue_free(),
	)
