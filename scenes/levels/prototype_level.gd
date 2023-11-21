extends Node2D
var playing_card_scene := preload("res://game_elements/cards/playing_card.tscn")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func _on_show_cards_toggled(button_pressed):
	if button_pressed:
		var new_card: playing_card = playing_card_scene.instantiate() as playing_card
		add_child(new_card)
