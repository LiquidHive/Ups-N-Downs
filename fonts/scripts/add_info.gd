extends Panel


onready var config = ConfigFile.new()

var file_path = "user://ConfigFile.txt"
var user_name

var name_text_cap
var name_text_lower


func _ready():
	$FavCombo/FavouriteToggle.connect("pressed", self, "fav_toggle")
	$Add.connect("pressed", self, "_on_Add_pressed")
	$CreateGroup.connect("pressed", self, "create_group")
	$Cancel.connect("pressed", self, "_on_Cancel_pressed")
	
	$Group.connect("pressed", self, "group")
	pass


func description():
	pass


func fav_toggle():
	if ($FavCombo/FavouriteToggle.text == "YES"):
		$FavCombo/FavouriteToggle.text = "NO"
	elif ($FavCombo/FavouriteToggle.text == "NO"):
		$FavCombo/FavouriteToggle.text = "YES"
	pass


func _on_Add_pressed():
	config.load(file_path)
	
	name_text_cap = $Name.text.capitalize()
	name_text_lower = $Name.text.to_lower()
	
	config.set_value("names", name_text_lower, $Name.text.capitalize())
	config.set_value("addresses", name_text_lower, $Address.text.capitalize())
	config.set_value("numbers", name_text_lower, $Telephone.text)
	config.set_value("descriptions", name_text_lower, $Description.text)
	config.set_value("town_name", name_text_lower, $Town.text.capitalize())
	
	if ($Group.text == "SELECT GROUP"):
		config.set_value("group_name", name_text_lower, "Null")
	else:
		config.set_value("group_name", name_text_lower, $Group.text)
	
	if ($FavCombo/FavouriteToggle.text == "NO"):
		config.set_value("favourite_name", name_text_lower, "O")
	elif ($FavCombo/FavouriteToggle.text == "YES"):
		config.set_value("favourite_name", name_text_lower, "I")
	
	user_name = name_text_cap
	config.save(file_path)
	self.hide()
	get_parent().refresh()
	pass # replace with function body


func create_group():
	$"../CreateGroup/Group".clear()
	$"../CreateGroup".show()
	pass


func _on_Cancel_pressed():
	get_tree().reload_current_scene()
	pass # replace with function body


func group():
	$"../GroupList".show()
	$"../GroupList".load_list()
	pass
