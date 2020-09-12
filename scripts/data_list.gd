extends Panel


onready var config = ConfigFile.new()
onready var file = File.new()

var file_path = "user://ConfigFile.txt"
var user_name

var name_text_cap
var name_text_lower


func _ready():
	$Save.connect("pressed", self, "_on_Save_pressed")
	$Edit.connect("pressed", self, "_on_Edit_pressed")
	$Cancel.connect("pressed", self, "_on_Cancel_pressed")
	$Group.connect("pressed", self, "group")
	$CreateGroup.connect("pressed", self, "create_group")
	$FavCombo/FavouriteToggle.connect("pressed", self, "fav_toggle")
	pass


func fav_toggle():
	if ($FavCombo/FavouriteToggle.text == "YES"):
		$FavCombo/FavouriteToggle.text = "NO"
	elif ($FavCombo/FavouriteToggle.text == "NO"):
		$FavCombo/FavouriteToggle.text = "YES"
	pass


func create_group():
	$"../CreateGroup/Group".clear()
	$"../CreateGroup".show()
	pass


func _on_Save_pressed():
	config.load(file_path)
	
	name_text_cap = $Name.text.capitalize()
	name_text_lower = $Name.text.to_lower()
	
	config.set_value("names", user_name, $Name.text.capitalize())
	config.set_value("addresses", user_name, $Address.text.capitalize())
	config.set_value("numbers", user_name, $Telephone.text)
	config.set_value("descriptions", user_name, $Description.text)
	config.set_value("town_name", user_name, $Town.text.capitalize())
	config.set_value("group_name", user_name, $Group.text)
	
	if ($FavCombo/FavouriteToggle.text == "NO"):
		config.set_value("favourite_name", user_name, "O")
	elif ($FavCombo/FavouriteToggle.text == "YES"):
		config.set_value("favourite_name", user_name, "I")
	
	config.save(file_path)
	self.hide()
	get_parent().refresh()
	pass # replace with function body


func _on_Edit_pressed():
	print($Edit.text)
	if ($Edit.text == "EDIT"):
		$Name.editable = true
		$Address.editable = true
		$Telephone.editable = true
		$Description.editable = true
		$Town.editable = true
		$Group.disabled = false
		$FavCombo/FavouriteToggle.disabled = false
		$Edit.text = "DONE"
	else:
		$Name.editable = false
		$Address.editable = false
		$Telephone.editable = false
		$Description.editable = false
		$Town.editable = false
		$Group.disabled = true
		$FavCombo/FavouriteToggle.disabled = true
		$Edit.text = "EDIT"
	pass # replace with function body


func _on_Cancel_pressed():
	self.hide()
	pass # replace with function body


func group():
	$"../GroupList".show()
	$"../GroupList".load_list()
	pass
