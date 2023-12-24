extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var deck_inst = get_parent().get_parent().deck_inst
	
	text = "Deck: "+ str(deck_inst.deck.size()) + "\nHand: " + str(deck_inst.hand.size()) + "\nGrave: " + str(deck_inst.grave.size())
