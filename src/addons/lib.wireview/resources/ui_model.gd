extends Resource

const Model := preload("./ui_model.gd")

var _batched := false
var _tracked: Dictionary[StringName, Variant] = { }
var _diff: Dictionary[StringName, Variant] = { }
var _updated: Array[StringName]

var cache: Dictionary[StringName, Variant] = { }
# var cache_hit: Dictionary[StringName, bool] = { }


func _init() -> void:
	for property in get_property_list():
		if property["usage"] & PROPERTY_USAGE_SCRIPT_VARIABLE:
			_tracked.set(property["name"], get(property["name"]))


func _set(property: StringName, value: Variant) -> bool:
	if value == get(property):
		return false

	if _batched:
		_tracked[property] = value
		return true

	_updated.clear()
	_diff = _tracked.duplicate()
	_tracked[property] = value

	if _diff[property] != _tracked[property]:
		cache[property] = false
		_updated.append(property)
		emit_changed()

	return true


func batch(task: Callable):
	return set_state(task)


func set_state(scope: Callable):
	var nested := true if _batched else false

	if not nested:
		_batched = true

	_updated.clear()
	_diff = _tracked.duplicate()
	scope.call()
	for key in _diff:
		if _diff[key] != _tracked[key]:
			_updated.append(key)

	if not nested:
		_batched = false
	emit_changed()


func declare_dependencies(key: StringName, resources: Array[Model]):
	if not cache.has(key):
		for resource in resources:
			resource.changed.connect(
				func():
					cache[key] = false,
			)


func deferred_effect(dependencies: Array[StringName], callback: Callable):
	changed.connect(
		func():
			if not dependencies.any(
				func(value):
					_updated.has(value),
			):
				return
			callback.call_deferred(),
		CONNECT_DEFERRED,
	)


func effect(dependencies: Array[StringName], callback: Callable):
	changed.connect(
		func():
			if not dependencies.any(
				func(value):
					_updated.has(value),
			):
				return
			callback.call(),
	)
