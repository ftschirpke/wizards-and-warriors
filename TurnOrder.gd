extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var combat_inst = get_parent().get_parent().combat_inst
	
	text = "Turn: " + str(combat_inst.turn_counter) + " |"
	for char in combat_inst.round_order:
		text = text + " " + str(char.id)
