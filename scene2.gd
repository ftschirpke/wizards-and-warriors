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

# variables for characters
var player_chars:Array = []
var player2_inst
var current_char
var prev_char

func switch_card(card):
	card.card_disabled = not card.card_disabled
	card.visible = not card.visible

func camera_follow_player(prev_player,player):
	if(prev_player == player):
		get_node("CameraFollow").reparent(player)
	else:
		prev_player.get_node("CameraFollow").reparent(player)
	var new_pos = player.get_node("CameraFollow")
	new_pos.remote_path = new_pos.get_path_to($MainCamera)
	new_pos.position = Vector2(0,0)

func _ready():
	# load players
	player_chars.append(preload("res://player.tscn").instantiate())
	add_child(player_chars[0])
	player_chars[0].position = Vector2(200,200)
	
	player_chars.append(preload("res://player.tscn").instantiate())
	add_child(player_chars[1])
	player_chars[1].position = Vector2(300,200)
	
	player_chars.append(preload("res://player.tscn").instantiate())
	add_child(player_chars[2])
	player_chars[2].position = Vector2(500,200)
	
	
	
	# load deck and cards
	#get_node("temp/Player UI/CardHolder").visible = false
	var i:int = 0
	for pc in player_chars:
		player_chars[i].player_id = str(i)
		pc.get_node("Player UI").visible = false
		char_list.append(char2.new("Player"+ str(i),10,30,i ))
		i += 1
	
	# load turn combat structure
	combat_inst = preload("res://turn_combat.tscn").instantiate()
	add_child(combat_inst)
	for char in char_list:
		var chartemp = combat_inst.char.new(str(char.id), char.speed)
		combat_inst.char_list.append(chartemp)
	combat_inst.start_round()
	
	# connect to signal of combat
	combat_inst.turn_change.connect(_on_turn_change)
	current_char = player_chars[int(combat_inst.round_order[0].id)]
	prev_char = current_char
	camera_follow_player(prev_char, current_char)
	current_char.get_node("Player UI").visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# main loop for battle
	if(not end_condition):
		pass
	
	
func _input(event):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_turn_change():
	
	prev_char.get_node("Player UI").visible = false
	
	current_char = player_chars[int(combat_inst.round_order[0].id)]
	camera_follow_player(prev_char,current_char)
	current_char.get_node("Player UI").visible = true
	prev_char = current_char
	
	
	
	
	
	
	
