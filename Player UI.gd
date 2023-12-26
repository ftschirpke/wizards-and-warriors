extends CanvasLayer

var hand_shown:bool = false
var deck_inst
var combat_inst
var combat_found:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	deck_inst = preload("res://deck.tscn").instantiate()
	add_child(deck_inst)
	get_node("CardHolder").visible =false
	for card in deck_inst.deck:
		deck_inst.add_child(card)
		switch_card(card)
	draw()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#combat_inst = get_parent().get_parent().get_node("Turn_Combat")
	if not combat_found:
		combat_inst = get_parent().get_parent().get_node("Turn_Combat")
		combat_found = true
	
	for card in deck_inst.hand:
		if(card.played):
			deck_inst.discard_card(card)
			switch_card(card)
	
func switch_card(card):
	card.card_disabled = not card.card_disabled
	card.visible = not card.visible

func _on_show_cards_toggled(button_pressed):
	get_node("CardHolder").visible = not get_node("CardHolder").visible
	hand_shown = not hand_shown
	for card in deck_inst.hand:
		switch_card(card)

func _on_end_turn_pressed():
	combat_inst.next_turn()
	get_parent().char_speedtemp = get_parent().CHAR_SPEED
	if(hand_shown):
		_on_draw_pressed()
	else:
		draw()
	
	
func _on_draw_pressed():
	if(not hand_shown):
		return
	for card in deck_inst.hand:
		switch_card(card)
	draw()
	for card in deck_inst.hand:
		switch_card(card)
	

func draw():
	deck_inst.deal(3)
	var hand_size:int = deck_inst.hand.size()
	var center = get_parent().get_parent().get_viewport_rect().size.x/2
	var start_x = center - 100*deck_inst.hand.size()/2
	var i:int = 0
	for card in deck_inst.hand:
		card.card_location = Vector2(start_x+i*100,500)
		i = i+1
		


func _on_discard_pressed():
	if(not hand_shown):
		return
	for card in deck_inst.hand:
		switch_card(card)
	deck_inst.discard_hand()
