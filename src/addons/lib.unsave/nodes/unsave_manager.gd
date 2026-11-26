@abstract
class_name UnsaveManager extends Node

@export_group("Metadata", "meta_")
@export var meta_extension: String
@export var meta_directory: String:
	get:
		if meta_directory.begins_with("res://"):
			return meta_directory
		return "res://{dir}".format({dir = meta_directory})


@abstract
func use_session()


@abstract
func acquire(slot)


@abstract
func release()


@abstract
func save()


func query_paths():
	var files := ResourceLoader.list_directory(meta_directory)
	var slots: Array[String] = []

	for file in files:
		if file.ends_with(meta_extension):
			slots.append("{dir}/{file}".format({
				dir = meta_directory,
				file = file,
			}))

	return slots


func query_recorders():
	var nodes: Array[Node] = get_tree().root.find_children("*", "UnsaveSnapshot")
	var snappers: Array[UnsaveSnapshot] = []

	for node in nodes:
		if node is UnsaveSnapshot:
			snappers.append(node)

	return snappers


func delete_slot(slot: UnsaveSlot):
	var path := "{dir}/{name}".format({
		dir = meta_directory,
		name = slot.resource_name,
	})

	DirAccess.remove_absolute(path)


func save_slot(slot: UnsaveSlot):
	for recorder in query_recorders():
		recorder.snap()

	var path := "{dir}/{name}".format({
		dir = meta_directory,
		name = slot.resource_name,
	})

	ResourceSaver.save(slot, path, slot.save_flags)


func load_slot(path: String) -> UnsaveSlot:
	return ResourceLoader.load(path) as UnsaveSlot
