extends Panel


onready var config = ConfigFile.new()
onready var file = File.new()

var file_path = "user://ConfigFile.txt"

var spreadsheet = preload("res://scenes/group_selector.tscn")

var instance


func _ready():
	$Cancel.connect("pressed", self, "cancel")
	pass


func load_list():
	config.load(file_path)
	
	for i in config.get_sections():
		if (i == "groups"):
			if (config.get_section_keys("groups") != null):
				for i in config.get_section_keys("groups").size():
					instance = spreadsheet.instance()
					$"MarginContainer/ScrollContainer/VBoxContainer".add_child(instance, true)
					instance.get_node("GroupName").text = config.get_value("groups", config.get_section_keys("groups")[i])
	pass


func cancel():
	for i in $"MarginContainer/ScrollContainer/VBoxContainer".get_children():
		i.queue_free()
	
	self.hide()
	pass
