 extends Node


onready var fav_tex = preload("res://assets/graphics/favourite.png")
onready var unfav_tex = preload("res://assets/graphics/unfavourite.png")


onready var config = ConfigFile.new()
onready var file = File.new()

# onready var title = $Panel/Title

onready var fav_lab = $Panel/FavLabel
onready var name_lab = $Panel/NameLabel
onready var tel_lab = $Panel/TelephoneLabel
onready var town_lab = $Panel/TownLabel
onready var group_lab = $Panel/GroupLabel

var window_size = Vector2()

var file_path = "user://ConfigFile.txt"

var spreadsheet = preload("res://scenes/container.tscn")
#var user_name
var instance

var interation = 0

var names = []
var towns = []
var groups = []
var favs = []

var names_dic = Dictionary()
var towns_dic = Dictionary()
var groups_dic = Dictionary()
var favs_dic = Dictionary()


func _ready():
	$"Panel/Add".connect("pressed", self, "add")
	$"Panel/Refresh".connect("pressed", self, "refresh")
	$"Panel/CreateGroup".connect("pressed", self, "create_group")
	$"Panel/DeleteGroup".connect("pressed", self, "delete_group")
	
	$"Panel/SortBy".connect("pressed", self, "sort_by")
	
	$"MarginContainer/ScrollContainer/VBoxContainer".margin_right = 1248
	
	window_size = OS.window_size
	
	if (file.file_exists(file_path)):
		config.load(file_path)
		
		if (config.get_value("groups", "null") == null):
			config.set_value("groups", "null", "Null")
		
		if (config.get_value("sort_by", "sort_by") == null):
			config.set_value("sort_by", "sort_by", "NAME")
		else:
			if (config.get_value("sort_by", "sort_by") == "NAME"):
				$"Panel/SortBy".text = "SORT BY: NAME"
			elif (config.get_value("sort_by", "sort_by") == "TOWN"):
				$"Panel/SortBy".text = "SORT BY: TOWN"
			elif (config.get_value("sort_by", "sort_by") == "GROUP"):
				$"Panel/SortBy".text = "SORT BY: GROUP"
			elif (config.get_value("sort_by", "sort_by") == "FAV"):
				$"Panel/SortBy".text = "SORT BY: FAV"
		
		sorted()
		
		if ($"Panel/SortBy".text == "SORT BY: NAME"):
			for i in config.get_sections():
				if (i == "names"):
					for name in config.get_section_keys("names").size():
						instance = spreadsheet.instance()
						$"MarginContainer/ScrollContainer/VBoxContainer".add_child(instance, true)
						
						instance.get_node("Name").text = config.get_value("names", config.get_section_keys("names")[interation])
						instance.get_node("Telephone").text = config.get_value("numbers", config.get_section_keys("names")[interation])
						instance.get_node("Town").text = config.get_value("town_name", config.get_section_keys("names")[interation])
						instance.get_node("Group").text = config.get_value("group_name", config.get_section_keys("names")[interation])
						instance.user_name = config.get_section_keys("names")[interation]
						
						if (config.get_value("favourite_name", config.get_section_keys("names")[interation]) == "I"):
							instance.get_node("Favourite").texture = fav_tex
						else:
							instance.get_node("Favourite").texture = unfav_tex
						interation += 1
		
		elif ($"Panel/SortBy".text == "SORT BY: TOWN"):
			for i in config.get_sections():
				if (i == "town_name"):
					for town in config.get_section_keys("town_name").size():
						instance = spreadsheet.instance()
						$"MarginContainer/ScrollContainer/VBoxContainer".add_child(instance, true)
						
						instance.get_node("Name").text = config.get_value("names", config.get_section_keys("town_name")[interation])
						instance.get_node("Telephone").text = config.get_value("numbers", config.get_section_keys("town_name")[interation])
						instance.get_node("Town").text = config.get_value("town_name", config.get_section_keys("town_name")[interation])
						instance.get_node("Group").text = config.get_value("group_name", config.get_section_keys("town_name")[interation])
						instance.user_name = config.get_section_keys("town_name")[interation]
						
						if (config.get_value("favourite_name", config.get_section_keys("town_name")[interation]) == "I"):
							instance.get_node("Favourite").texture = fav_tex
						else:
							instance.get_node("Favourite").texture = unfav_tex
						interation += 1
		
		elif ($"Panel/SortBy".text == "SORT BY: GROUP"):
			for i in config.get_sections():
				if (i == "group_name"):
					for town in config.get_section_keys("group_name").size():
						instance = spreadsheet.instance()
						$"MarginContainer/ScrollContainer/VBoxContainer".add_child(instance, true)
						
						instance.get_node("Name").text = config.get_value("names", config.get_section_keys("group_name")[interation])
						instance.get_node("Telephone").text = config.get_value("numbers", config.get_section_keys("group_name")[interation])
						instance.get_node("Town").text = config.get_value("town_name", config.get_section_keys("group_name")[interation])
						instance.get_node("Group").text = config.get_value("group_name", config.get_section_keys("group_name")[interation])
						instance.user_name = config.get_section_keys("group_name")[interation]
						
						if (config.get_value("favourite_name", config.get_section_keys("group_name")[interation]) == "I"):
							instance.get_node("Favourite").texture = fav_tex
						else:
							instance.get_node("Favourite").texture = unfav_tex
						interation += 1
		
		elif ($"Panel/SortBy".text == "SORT BY: FAV"):
			for i in config.get_sections():
				if (i == "favourite_name"):
					for town in config.get_section_keys("favourite_name").size():
						instance = spreadsheet.instance()
						$"MarginContainer/ScrollContainer/VBoxContainer".add_child(instance, true)
						
						instance.get_node("Name").text = config.get_value("names", config.get_section_keys("favourite_name")[interation])
						instance.get_node("Telephone").text = config.get_value("numbers", config.get_section_keys("favourite_name")[interation])
						instance.get_node("Town").text = config.get_value("town_name", config.get_section_keys("favourite_name")[interation])
						instance.get_node("Group").text = config.get_value("group_name", config.get_section_keys("favourite_name")[interation])
						instance.user_name = config.get_section_keys("favourite_name")[interation]
						
						if (config.get_value("favourite_name", config.get_section_keys("favourite_name")[interation]) == "I"):
							instance.get_node("Favourite").texture = fav_tex
						else:
							instance.get_node("Favourite").texture = unfav_tex
						interation += 1
	
	config.save(file_path)
	relocate_tittles()
	pass


func _process(delta):
	if (window_size != OS.window_size || OS.window_maximized || !OS.window_maximized):
		relocate_tittles()
		window_size = OS.window_size
	pass


func add():
	$"AddInfo/Name".clear()
	$"AddInfo/Address".clear()
	$"AddInfo/Telephone".clear()
	
	$"AddInfo".show()
	pass


func refresh():
	get_tree().reload_current_scene()
	pass


func sorted():
	config.load(file_path)
	
	if ($"Panel/SortBy".text == "SORT BY: NAME"):
		var name_interval = 0
		
		for nanme in config.get_sections(): # This sort all the values that are associated with names.
			if (nanme == "names"):
				for name_dic in config.get_section_keys("names"):
					names_dic[name_dic] = config.get_value("names", name_dic)
				
				while name_interval < config.get_section_keys("names").size():
					names.append(config.get_value("names", config.get_section_keys("names")[name_interval]))
					name_interval += 1
				names.sort()
				
				config.erase_section("names")
				
				for name_item in names:
					for name_dic_item in names_dic.values():
						if (name_dic_item == name_item):
							for name_val in names_dic.keys():
								if (names_dic[name_val] == name_dic_item):
									config.set_value("names", name_val, names_dic[name_val])
	
	if ($"Panel/SortBy".text == "SORT BY: TOWN"):
		var town_interval = 0
		
		for town in config.get_sections():
			if (town == "town_name"):
				for town_name in config.get_section_keys("town_name"):
					towns_dic[town_name] = config.get_value("town_name", town_name)
				
				while town_interval < config.get_section_keys("town_name").size():
					towns.append(config.get_value("town_name", config.get_section_keys("town_name")[town_interval]))
					town_interval += 1
				towns.sort()
				
				config.erase_section("town_name")
				
				for town_item in towns:
					for town_dic_item in towns_dic.values():
						if (town_dic_item == town_item):
							for town_val in towns_dic.keys():
								if (towns_dic[town_val] == town_dic_item):
									config.set_value("town_name", town_val, towns_dic[town_val])
	
	elif ($"Panel/SortBy".text == "SORT BY: GROUP"):
		var group_interval = 0
		
		for group in config.get_sections():
			if (group == "group_name"):
				for group_name_dic in config.get_section_keys("group_name"):
					groups_dic[group_name_dic] = config.get_value("group_name", group_name_dic)
				
				while group_interval < config.get_section_keys("group_name").size():
					groups.append(config.get_value("group_name", config.get_section_keys("group_name")[group_interval]))
					group_interval += 1
				groups.sort()
				
				config.erase_section("group_name")
				
				for group_item in groups:
					for group_dic_item in groups_dic.values():
						if (group_dic_item == group_item):
							for town_val in groups_dic.keys():
								if (groups_dic[town_val] == group_dic_item):
									config.set_value("group_name", town_val, groups_dic[town_val])
	
	elif ($"Panel/SortBy".text == "SORT BY: FAV"):
		var fav_interval = 0
		
		for fav in config.get_sections():
			if (fav == "favourite_name"):
				for fav_name_dic in config.get_section_keys("favourite_name"):
					favs_dic[fav_name_dic] = config.get_value("favourite_name", fav_name_dic)
				
				while fav_interval < config.get_section_keys("favourite_name").size():
					favs.append(config.get_value("favourite_name", config.get_section_keys("favourite_name")[fav_interval]))
					fav_interval += 1
				favs.sort()
				
				config.erase_section("favourite_name")
				
				for fav_item in favs:
					for fav_dic_item in favs_dic.values():
						if (fav_dic_item == fav_item):
							for fav_val in favs_dic.keys():
								if (favs_dic[fav_val] == fav_dic_item):
									config.set_value("favourite_name", fav_val, favs_dic[fav_val])
	
	config.save(file_path)
	pass


func create_group():
	$"CreateGroup/Group".clear()
	$"CreateGroup".show()
	pass


func delete_group():
	$"DelGroup".show()
	$"DelGroup".load_list()
	pass


func sort_by():
	config.load(file_path)
	
	if ($"Panel/SortBy".text == "SORT BY: NAME"):
		$"Panel/SortBy".text = "SORT BY: TOWN"
		config.set_value("sort_by", "sort_by", "TOWN")
	elif ($"Panel/SortBy".text == "SORT BY: TOWN"):
		$"Panel/SortBy".text = "SORT BY: GROUP"
		config.set_value("sort_by", "sort_by", "GROUP")
	elif ($"Panel/SortBy".text == "SORT BY: GROUP"):
		$"Panel/SortBy".text = "SORT BY: FAV"
		config.set_value("sort_by", "sort_by", "FAV")
	elif ($"Panel/SortBy".text == "SORT BY: FAV"):
		$"Panel/SortBy".text = "SORT BY: NAME"
		config.set_value("sort_by", "sort_by", "NAME")
	
	config.save(file_path)
	get_tree().reload_current_scene()
	pass


func relocate_tittles():
	if ($"MarginContainer/ScrollContainer/VBoxContainer".get_child_count() > 0):
		fav_lab.rect_global_position.x = $"MarginContainer/ScrollContainer/VBoxContainer".get_child(0).get_node("Favourite").rect_global_position.x
		name_lab.rect_global_position.x = $"MarginContainer/ScrollContainer/VBoxContainer".get_child(0).get_node("Name").rect_global_position.x
		tel_lab.rect_global_position.x = $"MarginContainer/ScrollContainer/VBoxContainer".get_child(0).get_node("Telephone").rect_global_position.x
		town_lab.rect_global_position.x = $"MarginContainer/ScrollContainer/VBoxContainer".get_child(0).get_node("Town").rect_global_position.x
		group_lab.rect_global_position.x = $"MarginContainer/ScrollContainer/VBoxContainer".get_child(0).get_node("Group").rect_global_position.x
	pass
