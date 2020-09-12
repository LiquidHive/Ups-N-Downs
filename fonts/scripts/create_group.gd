extends Panel


onready var config = ConfigFile.new()
onready var file = File.new()

var file_path = "user://ConfigFile.txt"


func _ready():
	$Save.connect("pressed", self, "save")
	$Cancel.connect("pressed", self, "cancel")
	pass


func save():
	config.load(file_path)
	
	if ($Group.text != null):
		config.set_value("groups", $Group.text.to_lower(), $Group.text.capitalize())
	
	config.save(file_path)
	
	if ($"../DataList".is_visible()):
		self.hide()
	else:
		get_tree().reload_current_scene()
	pass


func cancel():
	self.hide()
	pass
