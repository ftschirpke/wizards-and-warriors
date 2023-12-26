extends CharacterBody2D
class_name PlayerChar

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var timer := $Timer as Timer


const SPEED:float = 100.0
const CHAR_SPEED:int = 10
const HP_MAX: int = 30

var player_id:String

var target_loc: = Vector2(0,0)
var current_loc:Vector2

var vel:float
var move:bool = false

var char_speedtemp:int = CHAR_SPEED
var hp_current:int = HP_MAX

var combat_inst

var combat_found:bool = false


func _ready():
	combat_inst = get_parent().get_node("Turn_Combat")



func _physics_process(delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * SPEED * delta * 50
	if( (position - target_loc).length() <= (velocity*delta).length()  and move):
		move = false
		position = target_loc
	elif(char_speedtemp == 0):
		move = false

	if(move):
		move_and_slide()
	

func _process(delta) -> void:
	if(not combat_found):
		combat_inst = get_parent().get_node("Turn_Combat")
		combat_found = true
	


func getpath() -> void:
	nav_agent.target_position = target_loc
	move = false

func _input(event):
	if combat_inst.round_order.front().id != player_id:
		target_loc = position
		getpath()
		return
	
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			target_loc = get_global_mouse_position()
			getpath()
			
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			move = true
			#char_speedtemp = CHAR_SPEED
			timer.start()


func _on_timer_timeout():
	if(move):
		char_speedtemp = char_speedtemp -1
		if(char_speedtemp == 0):
			timer.stop()
			

func attack() -> void:
	pass










