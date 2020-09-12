extends Control


onready var config = ConfigFile.new()
onready var file = File.new()

var file_path = "user://ConfigFile.txt"


func _ready():
	$Delete.connect("pressed", self, "delete")
	pass


func delete():
	config.load(file_path)
	
	var group_name = $Group.text
	
	print("\n\n" + "Group Name: " + group_name)
	
	var group_num = 0
	
	var groups_dic = Dictionary()
	var groups_lis = []
	
	for group_keys_dic in config.get_section_keys("groups"):
		groups_dic[group_keys_dic] = config.get_value("groups", group_keys_dic)
	
	print("Group Dictionary: " + str(groups_dic))
	
	for user_groups in config.get_section_keys("groups"):
		if (group_name != config.get_value("groups", user_groups)):
			group_num += 1
			print(group_num)
		else:
			print("Found Group Name In ConfigFile!")
			
			var groups = config.get_section_keys("groups")
			groups.remove(group_num)
			
			for group_list in groups:
				groups_lis.append(group_list)
			break
	
	print("Group List: " + str(groups_lis))
	
	config.erase_section("groups")
	
	for has_group in config.get_section_keys("group_name"):
		if (group_name == config.get_value("group_name", has_group)):
			config.set_value("group_name", has_group.to_lower(), "Null")
	
	for group_item in groups_lis:
		for group_dic_item in groups_dic:
			if (group_item == group_dic_item):
				config.set_value("groups", group_item, groups_dic[group_item])
	
	config.save(file_path)
	get_tree().reload_current_scene()
	pass
