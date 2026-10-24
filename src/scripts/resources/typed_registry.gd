@tool
@abstract
class_name TypedRegistry extends Registry


## Loads the resource associated with [param id] (string ID or UID) and returns it.
## Returns [code]null[/code] if the entry does not exist or cannot be loaded.[br][br]
##
## [param type_hint] and [param cache_mode] are passed down to
## [method ResourceLoader.load].
@abstract
func typed_load_entry(
	id: StringName,
	type_hint: String = "",
	cache_mode: ResourceLoader.CacheMode = ResourceLoader.CacheMode.CACHE_MODE_REUSE,
)


@abstract
func typed_load_entries(ids: Array[StringName])

## Loads all registered resources in a blocking manner. Returns a dictionary
## mapping string IDs to their loaded [Resource] instances.
## Missing or invalid entries are skipped.[br][br]
##
## [param type_hint] and [param cache_mode] are passed down to
## [method ResourceLoader.load].


@abstract
func typed_load_all_blocking()


func load_entries(ids: Array[StringName]):
	var entries: Dictionary[StringName, Resource] = { }

	for id in ids:
		entries[id] = load_entry(id)

	return entries
