class_name PlayingCard extends Control

# define default values
var card_location_origin: Vector2
var mouse_offset: Vector2
var dragged: bool = false

@onready var color_rect: ColorRect = $CardColor
@onready var card_button: Button = $CardButton
@onready var label: Label = $CardLabel

@export var card_color: Color = Color(0.118, 0.337, 0.118)
@export var card_size: Vector2
@export var card_attribute: int

func _ready() -> void:
    self.custom_minimum_size = card_size
    color_rect.color = card_color
    label.text = "Card %d" % card_attribute

func _physics_process(_delta) -> void:
    if dragged:
        self.global_position = get_global_mouse_position() - mouse_offset

func _on_card_button_button_down() -> void:
    card_location_origin = self.global_position
    mouse_offset = get_local_mouse_position()
    dragged = true

func _on_card_button_button_up() -> void:
    dragged = false
    self.global_position = card_location_origin
