extends Label

func _on_player_hp_changed(hp_current: int, hp_max) -> void:
    text = "HP: {hp_current} / {hp_max}".format({"hp_current": hp_current, "hp_max": hp_max})
