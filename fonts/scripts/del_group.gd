extends Panel


onready var config = ConfigFile.new()
onready var file = File.new()

var file_path = "user://ConfigFile.txt"

var spreadsheet = preload("res://scenes/group_container.tscn")
var instance

var interation


func _ready():
	$Cancel.connect("pressed", self, "cancel")
	pass


func cancel():
	get_tree().reload_current_scene()
	pass


func load_list():
	interation = 0
	
	if (file.file_exists(file_path)):
		config.load(file_path)
		
		for i in config.get_sections():
			if (i == "groups"):
				for name in config.get_section_keys("groups").size():
					instance = spreadsheet.instance()
					$"MarginContainer/ScrollContainer/VBoxContainer".add_child(instance, true)
					
					for  g in config.get_sections():
						if (g == "groups"):
							if (config.get_section_keys("groups") != null):
								for i in config.get_section_keys("groups").size():
									if (config.get_value("groups", config.get_section_keys("groups")[interation])):
										instance.get_node("Group").text = config.get_value("groups", config.get_section_keys("groups")[interation])
									
									if (config.get_value("groups", config.get_section_keys("groups")[interation]) == "Null"):
										instance.get_node("Delete").queue_free()
					interation += 1
	pass # Replace with function body.
