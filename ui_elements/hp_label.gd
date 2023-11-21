extends Label

func _process(_delta):
	text = "HP: " + str(get_node("../../Player").HP_MAX) + " / " + str(get_node("../../Player").hp_current)
