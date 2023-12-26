extends Node2D

class char:
	var id:String
	var speed:int
	
	func _init(id,speed):
		self.id = id
		self.speed = speed

var end_condition:bool = false

var round_order:Array = []
var char_list:Array = []
var turn_counter:int = 0
signal turn_change



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(end_condition):
		emit_signal("ready")
	


func start_round():
	for char in char_list:
		enter_combat(char)
	turn_counter += 1

func enter_combat(char:char):
	round_order.append(char)
	# sort current round by speed
	round_order.sort_custom(func(a,b)->int: return b.speed - a.speed)
	# make sure the new char cant skip the current by being faster
	if(char == round_order[0] and round_order.size()>1):
		var temp = round_order[0]
		round_order[0] = round_order[1]
		round_order[1] = temp
	
	
	
func next_turn():
	
	if(not round_order.is_empty()):
		round_order.pop_front()
	if(round_order.is_empty()):
		start_round()
	
	# emit signal for scene
	turn_change.emit()







