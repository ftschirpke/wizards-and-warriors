extends Node2D
var playing_card_scene = preload("res://playing_card.tscn")

var deck_inst
var hand_shown:bool = false
# Called when the node enters the scene tree for the first time.







func switch_card(card):
	card.card_disabled = not card.card_disabled
	card.visible = not card.visible

func _ready():
	var ui = $"Player UI"
	deck_inst = preload("res://deck.tscn").instantiate()
	ui.add_child(deck_inst)
	# preload all the cards in the deck (maybe loading and reloading them works aswell)
	# deactivate all 
	for card in deck_inst.deck:
		deck_inst.add_child(card)
		switch_card(card)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_show_cards_toggled(button_pressed):
	hand_shown = not hand_shown
	for card in deck_inst.hand:
		switch_card(card)



func _on_draw_pressed():
	if(not hand_shown):
		return
	for card in deck_inst.hand:
		switch_card(card)
	
	deck_inst.deal(3)
	var hand_size:int = deck_inst.hand.size()
	var i:int = 0
	for card in deck_inst.hand:
		card.card_location = Vector2(500+i*100,500)
		switch_card(card)
		i = i+1
	
	
func _on_discard_pressed():
	for card in deck_inst.hand:
		switch_card(card)
	deck_inst.discard()
	
# TODO: dsiplay deck and discard	
	
	
	
	
	
	
