extends HBoxContainer


func _ready():
	$"GroupName".connect("pressed", self, "is_pressed")
	pass


func is_pressed():
	$"../../../../../AddInfo/Group".text = $"GroupName".text
	$"../../../../../DataList/Group".text = $"GroupName".text
	$"../../../../".hide()
	
	for i in $"../".get_children():
		i.queue_free()
	pass
