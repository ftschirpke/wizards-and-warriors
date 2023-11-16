extends Node2D
var playing_card_scene = preload("res://playing_card.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_show_cards_toggled(button_pressed):
	if(button_pressed):
		var new_card: playing_card = playing_card_scene.instantiate() as playing_card
		add_child(new_card)
