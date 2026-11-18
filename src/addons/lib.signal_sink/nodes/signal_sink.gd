@icon("res://addons/at-icons/node/emitter.svg")

class_name SignalSink extends Node


const Sink := preload("res://addons/lib.signal_sink/nodes/signal_sink.gd")


var signals: Dictionary[StringName, Signal] = {}


func scoped(name: StringName = &"*", node: Node = self) -> Sink:
	var sinks := node.find_children(name, &"SignalSink")
	if sinks.is_empty():
		return

	return sinks[0]


func from_topic(topic: StringName) -> Variant:
	return await signals[topic]


func message(data: Variant, topics: Array[StringName] = []):
	if topics.is_empty():
		for transmitter in signals.values() as Array[Signal]:
			transmitter.emit(data)
		return self

	for topic in topics:
		signals[topic].emit(data)
	return self


func messages(messages: Array, topics: Array[StringName] = [], ):
	for data in messages:
		message(data, topics)
	return self


func sink(topic: StringName, receiver: Callable, flags: ConnectFlags = 0):
	if not signals.has(topic):
		signals[topic] = Signal(self, topic)
	signals[topic].connect(receiver, flags)
	return self
