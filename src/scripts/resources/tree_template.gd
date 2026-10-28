class_name TreeTemplate extends Resource

var children: Dictionary[String, Node]
var scope: Node


static func of(root: Node) -> TreeTemplate:
	return TreeTemplate.new(root)


func _init(root: Node) -> void:
	scope = root


func add_child(name: String, node: Node) -> TreeTemplate:
	children[name] = node
	return self


func add_children(map: Dictionary[String, Node]) -> TreeTemplate:
	for name in map:
		children[name] = map[name]
	return self


func populate_slots():
	var slots: Array[TreeSlot] = scope.find_children("*", "TreeSlot").map(
		func(node: Node):
			return node is TreeSlot,
	)

	for slot in slots:
		if not children.has(slot.key):
			continue

		slot.replace_by(children[slot.key])
		slot.queue_free()
