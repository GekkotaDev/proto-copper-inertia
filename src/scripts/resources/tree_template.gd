class_name TreeTemplate extends Resource

var templates: Dictionary[String, Node]
var scope: Node


static func of(root: Node) -> TreeTemplate:
	return TreeTemplate.new().bind(root)


func bind(root: Node) -> TreeTemplate:
	scope = root
	return self


func add_child(name: String, node: Node) -> TreeTemplate:
	templates[name] = node
	return self


func add_children(map: Dictionary[String, Node]) -> TreeTemplate:
	for name in map:
		templates[name] = map[name]
	return self


func populate_slot():
	var slots: Array[TreeSlot] = []

	for slot in scope.find_children("*", "TreeSlot"):
		if slot is TreeSlot:
			slots.append(slot)
		if slot is TreeSlot2D:
			slots.append(slot)
		if slot is TreeSlot3D:
			slots.append(slot)

	for slot in slots:
		if templates.has(slot.key):
			slot.replace_by(templates[slot.key])
			slot.queue_free()
			break


func populate_slots():
	var slots: Array[TreeSlot] = []

	for slot in scope.find_children("*", "TreeSlot"):
		if slot is TreeSlot:
			slots.append(slot)
		if slot is TreeSlot2D:
			slots.append(slot)
		if slot is TreeSlot3D:
			slots.append(slot)

	for slot in slots:
		if not templates.has(slot.key):
			continue

		slot.replace_by(templates[slot.key])
		slot.queue_free()
