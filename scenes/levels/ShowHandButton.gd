extends Button

func _on_toggled(button_just_pressed: bool) -> void:
    text = "Hide Hand" if button_just_pressed else "Show Hand"
