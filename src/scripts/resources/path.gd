class_name FilePath extends Resource

@export var location: String:
	get:
		return erase_prefixes(location, _prefixes).simplify_path()
	set(value):
		location = value

static var _prefixes := ["res://", "user://"]


static func erase_prefixes(string: String, prefixes: PackedStringArray) -> String:
	var result := string

	for prefix in prefixes:
		if result.begins_with(prefix):
			result = result.erase(0, prefix.length())

	return result


static func is_res(path: String) -> bool:
	return path.begins_with("res://")


static func is_user(path: String) -> bool:
	return path.begins_with("user://")


func _init(path: String) -> void:
	location = erase_prefixes(path, _prefixes)


func as_res() -> String:
	if is_relative():
		return location
	return "res://{path}".format({ path = location })


func as_user() -> String:
	if is_relative():
		return location
	return "user://{path}".format({ path = location })


func as_extension() -> String:
	return location.get_extension()


func as_file() -> String:
	return location.get_file()


func as_file_without_extension() -> String:
	return as_file().get_basename()


func is_absolute() -> bool:
	return not is_relative()


func is_relative() -> bool:
	return location.begins_with("./") or location.begins_with("../")


func is_valid() -> bool:
	return location.is_valid_filename()


func to_base_directory() -> FilePath:
	location = location.get_base_dir()
	return self


func to_base_name() -> FilePath:
	location = location.get_basename()
	return self


func to_validated() -> FilePath:
	location = location.validate_filename()
	return self


func join(other: String) -> FilePath:
	location = location.path_join(other)
	return self


func parent() -> FilePath:
	var split: Array[String] = location.split("/")
	split.pop_back()
	location = "/".join(split)
	return self


func _to_string() -> String:
	return location
