extends Node2D
class_name playing_card

#define default values
var card_location_origin:Vector2
var dragged:bool = false
var offset:Vector2

@onready var color_rect: ColorRect = $Card_Color
@onready var card_button: Button = $Card_Button

@export var card_location: Vector2
@export var card_color: Color
@export var card_size: Vector2
@export var card_attribute: int
@export var card_disabled:bool = false


# Called when the node enters the scene tree for the first time
func _ready():
	var color_rect: ColorRect = $Card_Color
	var card_button: Button = $Card_Button
	self.position = card_location
	card_location_origin = card_location
	
	color_rect.color = card_color
	color_rect.size = card_size
	
	card_button.size = card_size
	card_button.disabled = card_disabled
	card_button.text = "CARD\n" + str(card_attribute)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(not dragged):
		self.position = card_location
		card_location_origin = card_location
	
	color_rect.color = card_color
	color_rect.size = card_size
	
	card_button.size = card_size
	card_button.disabled = card_disabled
	

#handle physics of the card (dragging/playing usw)
func _physics_process(delta) -> void:
	
	if(dragged):
		self.position = get_global_mouse_position() + offset
	else:
		self.position  = card_location_origin

func _on_card_button_button_down():
	dragged = true
	offset = self.position - get_global_mouse_position()


func _on_card_button_button_up():
	dragged = false
