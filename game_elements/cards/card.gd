extends Node2D
class_name playing_card

# define default values
var card_location_origin: Vector2
var dragged: bool = false

@onready var color_rect: ColorRect = $Card_Color
@onready var card_button: Button = $Card_Button

@export var card_location: Vector2
@export var card_color: Color
@export var card_size: Vector2
@export var card_attribute: int

func _ready() -> void:
	self.position = card_location
	card_location_origin = card_location
	color_rect.color = card_color
	card_button.size = card_size
	color_rect.size = card_size

func _physics_process(_delta) -> void:
	if dragged:
		self.position = get_global_mouse_position()
	else:
		self.position = card_location_origin

func _on_card_button_button_down() -> void:
	dragged = true

func _on_card_button_button_up() -> void:
	dragged = false
