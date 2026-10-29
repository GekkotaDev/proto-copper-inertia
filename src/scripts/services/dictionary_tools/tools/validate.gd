static func parse(data: Variant, schema: Dictionary[String, Callable]) -> bool:
	if data is Dictionary:
		var valid := true

		for key in data.keys():
			var result: bool = schema[key].call(data[key])
			valid = result and valid
		return valid

	return false
