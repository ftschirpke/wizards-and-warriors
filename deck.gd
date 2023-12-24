extends Node2D

var cards:Array = [1, 2, 3, 4, 5, 6]
var deck:Array = []
var hand:Array = []
var grave:Array = []



# Called when the node enters the scene tree for the first time.
func _ready():
	generate_deck()
	shuffle()
	
func generate_deck():
	for value in cards:
		var card_inst = preload("res://playing_card.tscn").instantiate()
		card_inst.card_attribute = value
		deck.append(card_inst)

func shuffle():
	deck.shuffle()

func cycle_grave():
	for i in range(grave.size()):
		deck.append(grave.pop_back())
	shuffle()
	
func discard():
	for i in range(hand.size()):
		grave.append(hand.pop_back())
	
func deal(count:int):
	# discard hand into graveyard
	for i in range(hand.size()):
		grave.append(hand.pop_back())
	
	# draw new hand from deck, if deck empty reshuffle grave into deck then keep going
	for i in range(count):
		if deck.size() == 0:
			cycle_grave()
		hand.append(deck.pop_back())
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
