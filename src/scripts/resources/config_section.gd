class_name ConfigSection extends Resource

@export var section: StringName
@export var settings: Dictionary[StringName, Variant]


func apply(config: ConfigFile):
	for setting_name in settings:
		config.set_value(section, setting_name, settings[setting_name])
