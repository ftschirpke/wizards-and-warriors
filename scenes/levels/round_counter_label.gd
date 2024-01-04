extends Label

func _on_change_round_counter_ui(round_number: int) -> void:
    text = "Round: %d" % round_number
