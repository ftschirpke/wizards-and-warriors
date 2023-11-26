extends Node2D
var playing_card_scene := load("res://game_elements/cards/playing_card.tscn")

@onready var deck_ui := $UIOverlay/UIMargin/DeckUI
@onready var deck_node := $UIOverlay/UIMargin/DeckUI/DeckPanelMargin/DeckHolder

func _ready() -> void:
    deck_ui.visible = false

func _on_show_hand_button_toggled(button_pressed: bool) -> void:
    deck_ui.visible = button_pressed

func _on_add_card_button_pressed() -> void:
    var new_card: playing_card = playing_card_scene.instantiate() as playing_card
    deck_node.add_child(new_card)
