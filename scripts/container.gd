extends HBoxContainer


onready var config = ConfigFile.new()
onready var file = File.new()

var file_path = "user://ConfigFile.txt"

var user_name


func _on_MoreInfo_pressed():
	config.load(file_path)
	
	$"../../../../DataList/Name".editable = false
	$"../../../../DataList/Address".editable = false
	$"../../../../DataList/Telephone".editable = false
	$"../../../../DataList/Description".editable = false
	$"../../../../DataList/Town".editable = false
	$"../../../../DataList/Group".disabled = true
	$"../../../../DataList/FavCombo/FavouriteToggle".disabled = true
	$"../../../../DataList/Edit".text = "EDIT"
	$"../../../../DataList".user_name = user_name
	$"../../../../DataList/Name".text = $"../../../../".config.get_value("names", user_name)
	
	if (config.get_value("addresses", user_name) != null):
		$"../../../../DataList/Address".text = $"../../../../".config.get_value("addresses", user_name)
	
	if (config.get_value("numbers", user_name) != null):
		$"../../../../DataList/Telephone".text = $"../../../../".config.get_value("numbers", user_name)
	
	if (config.get_value("descriptions", user_name) != null):
		$"../../../../DataList/Description".text = $"../../../../".config.get_value("descriptions", user_name)
	
	if (config.get_value("town_name", user_name) != null):
		$"../../../../DataList/Town".text = $"../../../../".config.get_value("town_name", user_name)
	
	$"../../../../DataList/Group".text = config.get_value("group_name", user_name)
	
	if (config.get_value("favourite_name", user_name) != null):
		if ($"../../../../".config.get_value("favourite_name", user_name) == "I"):
			$"../../../../DataList/FavCombo/FavouriteToggle".text = "YES"
		else:
			$"../../../../DataList/FavCombo/FavouriteToggle".text = "NO"
	
	variables.user_name = $"../../../../".config.get_value("names", user_name)
	$"../../../../DataList".show()
	pass # replace with function body


func _on_Delete_pressed():
	config.load(file_path)
	
	var name_num = 0
	var address_num = 0
	var numbers_num = 0
	var description_num = 0
	var town_num = 0
	var group_num = 0
	var fav_num = 0
	
	var names_dic = Dictionary()
	var names_lis = []
	
	var addresses_dic = Dictionary()
	var addresses_lis = []
	
	var numbers_dic = Dictionary()
	var numbers_lis = []
	
	var descriptions_dic = Dictionary()
	var descriptions_lis = []
	
	var towns_dic = Dictionary()
	var towns_lis = []
	
	var groups_dic = Dictionary()
	var groups_lis = []
	
	var favs_dic = Dictionary()
	var favs_lis = []
	
	for name_dic in config.get_section_keys("names"):
		names_dic[name_dic] = config.get_value("names", name_dic)
	
	for address_dic in config.get_section_keys("addresses"):
		addresses_dic[address_dic] = config.get_value("addresses", address_dic)
	
	for number_dic in config.get_section_keys("numbers"):
		numbers_dic[number_dic] = config.get_value("numbers", number_dic)
	
	for description_dic in config.get_section_keys("descriptions"):
		descriptions_dic[description_dic] = config.get_value("descriptions", description_dic)
	
	for town_name_dic in config.get_section_keys("town_name"):
		towns_dic[town_name_dic] = config.get_value("town_name", town_name_dic)
	
	for group_name_dic in config.get_section_keys("group_name"):
		groups_dic[group_name_dic] = config.get_value("group_name", group_name_dic)
	
	for fav_name_dic in config.get_section_keys("favourite_name"):
		favs_dic[fav_name_dic] = config.get_value("favourite_name", fav_name_dic)
	
	for user_names in config.get_section_keys("names"):
		if (user_names != user_name):
			name_num += 1
		else:
			var names = config.get_section_keys("names")
			names.remove(name_num)
			for name_list in names:
				names_lis.append(name_list)
	
	for user_addresses in config.get_section_keys("addresses"):
		if (user_addresses != user_name):
			address_num += 1
		else:
			var addresses = config.get_section_keys("addresses")
			addresses.remove(address_num)
			for address_list in addresses:
				addresses_lis.append(address_list)
	
	for user_numbers in config.get_section_keys("numbers"):
		if (user_numbers != user_name):
			numbers_num += 1
		else:
			var numbers = config.get_section_keys("numbers")
			numbers.remove(numbers_num)
			for number_list in numbers:
				numbers_lis.append(number_list)
	
	for user_descriptions in config.get_section_keys("descriptions"):
		if (user_descriptions != user_name):
			description_num += 1
		else:
			var descriptions = config.get_section_keys("descriptions")
			descriptions.remove(description_num)
			for description_list in descriptions:
				descriptions_lis.append(description_list)
	
	for user_towns in config.get_section_keys("town_name"):
		if (user_towns != user_name):
			town_num += 1
		else:
			var towns = config.get_section_keys("town_name")
			towns.remove(town_num)
			for town_list in towns:
				towns_lis.append(town_list)
	
	for user_groups in config.get_section_keys("group_name"):
		if (user_groups != user_name):
			group_num += 1
		else:
			var groups = config.get_section_keys("group_name")
			groups.remove(group_num)
			for group_list in groups:
				groups_lis.append(group_list)
	
	for user_fav in config.get_section_keys("favourite_name"):
		if (user_fav != user_name):
			fav_num += 1
		else:
			var favs = config.get_section_keys("favourite_name")
			favs.remove(fav_num)
			for favs_list in favs:
				favs_lis.append(favs_list)
	
	config.erase_section("names")
	config.erase_section("addresses")
	config.erase_section("numbers")
	config.erase_section("descriptions")
	config.erase_section("town_name")
	config.erase_section("group_name")
	config.erase_section("favourite_name")
	
	for name_item in names_lis:
		for name_dic_item in names_dic:
			if (name_item == name_dic_item):
				config.set_value("names", name_item, names_dic[name_item])
	
	for address_item in addresses_lis:
		for address_dic_item in addresses_dic:
			if (address_item == address_dic_item):
				config.set_value("addresses", address_item, addresses_dic[address_item])
	
	for numbers_item in numbers_lis:
		for numbers_dic_item in numbers_dic:
			if (numbers_item == numbers_dic_item):
				config.set_value("numbers", numbers_item, numbers_dic[numbers_item])
	
	for description_item in descriptions_lis:
		for description_dic_item in descriptions_dic:
			if (description_item == description_dic_item):
				config.set_value("descriptions", description_item, descriptions_dic[description_item])
	
	for town_item in towns_lis:
		for towns_dic_item in towns_dic:
			if (town_item == towns_dic_item):
				config.set_value("town_name", town_item, towns_dic[town_item])
	
	for group_item in groups_lis:
		for group_dic_item in groups_dic:
			if (group_item == group_dic_item):
				config.set_value("group_name", group_item, groups_dic[group_item])
	
	for fav_item in favs_lis:
		for fav_dic_item in favs_dic:
			if (fav_item == fav_dic_item):
				config.set_value("favourite_name", fav_item, favs_dic[fav_item])
	
	config.save(file_path)
	$"../../../../".refresh()
	pass # replace with function body
