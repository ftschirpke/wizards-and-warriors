class_name PlayerUI extends CanvasLayer

@onready var deck_ui: PanelContainer = $PlayerUIMargin/DeckUI
@onready var deck_node: HBoxContainer = $PlayerUIMargin/DeckUI/DeckPanelMargin/DeckPanelCentering/DeckHolder
@onready var hand_label: Label = $PlayerUIMargin/PlayerUIFooterRight/HandLabel
@onready var deck_label: Label = $PlayerUIMargin/PlayerUIFooterRight/DeckLabel
@onready var grave_label: Label = $PlayerUIMargin/PlayerUIFooterRight/GraveLabel
@onready var end_turn_button: Button = $PlayerUIMargin/PlayerUIFooterRight/EndTurnButton

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
