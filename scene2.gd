extends Node2D

class char2:
	var name:String
	var speed:int
	var hp:int
	var id:int
	
	func _init(name,speed,hp,id):
		self.name = name
		self.speed = speed
		self.hp = hp
		self.id = id

# variables for deck
#var playing_card_scene = preload("res://playing_card.tscn")
var deck_inst
var hand_shown:bool = false

# variables for turn-system
var combat_inst
var end_condition:bool = false
var char_list:Array = []



func switch_card(card):
	card.card_disabled = not card.card_disabled
	card.visible = not card.visible

func _ready():
	# load deck and cards
	get_node("Player UI/CardHolder").visible = false
	var ui = $"Player UI"
	deck_inst = preload("res://deck.tscn").instantiate()
	ui.add_child(deck_inst)
	# preload all the cards in the deck (maybe loading and reloading them works aswell)
	# deactivate all 
	for card in deck_inst.deck:
		deck_inst.add_child(card)
		switch_card(card)
	
	char_list.append( char2.new("Player", 10, 30, 0))
	
	# load turn combat structure
	combat_inst = preload("res://turn_combat.tscn").instantiate()
	add_child(combat_inst)
	for char in char_list:
		var char2 = combat_inst.char.new(char.name, char.speed)
		combat_inst.char_list.append(char2)
	combat_inst.start_round()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# deck: check if card is played
	for card in deck_inst.hand:
		if(card.played):
			deck_inst.discard_card(card)
			switch_card(card)
			
	# main loop for battle
	if(not end_condition):
		pass
	
	
func _input(event):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_show_cards_toggled(button_pressed):
	hand_shown = not hand_shown
	for card in deck_inst.hand:
		switch_card(card)
	get_node("Player UI/CardHolder").visible = hand_shown


func _on_draw_pressed():
	if(not hand_shown):
		return
	for card in deck_inst.hand:
		switch_card(card)
	
	deck_inst.deal(3)
	var hand_size:int = deck_inst.hand.size()
	var center = get_viewport_rect().size.x/2
	var start_x = center - 100*deck_inst.hand.size()/2
	var i:int = 0
	for card in deck_inst.hand:	
		card.card_location = Vector2(start_x+i*100,500)
		switch_card(card)
		i = i+1
	
	
func _on_discard_pressed():
	if(not hand_shown):
		return
	for card in deck_inst.hand:
		switch_card(card)
	deck_inst.discard_hand()
	

func _on_end_turn_pressed():
	combat_inst.next_turn()
	





