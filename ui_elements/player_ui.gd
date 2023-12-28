extends CanvasLayer
class_name PlayerUI

@onready var deck_ui := $PlayerUIMargin/DeckUI
@onready var deck_node := $PlayerUIMargin/DeckUI/DeckPanelMargin/DeckPanelCentering/DeckHolder
@onready var hand_label := $PlayerUIMargin/PlayerUIFooterRight/HandLabel
@onready var deck_label := $PlayerUIMargin/PlayerUIFooterRight/DeckLabel
@onready var grave_label := $PlayerUIMargin/PlayerUIFooterRight/GraveLabel

func _ready() -> void:
    deck_ui.visible = false

func _on_show_hand_button_toggled(button_pressed: bool) -> void:
    deck_ui.visible = button_pressed

func _on_hand_changed(hand: Array, deck_size: int, grave_size: int) -> void:
    for child in deck_node.get_children():
        deck_node.remove_child(child)
    for card in hand:
        deck_node.add_child(card)
    hand_label.text = "Hand: %s" % hand.size()
    deck_label.text = "Deck: %s" % deck_size
    grave_label.text = "Grave: %s" % grave_size
