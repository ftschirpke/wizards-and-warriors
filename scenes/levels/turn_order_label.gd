extends Label

func _on_change_turn_order_ui(turn_order_strings: Array) -> void:
    text = ", ".join(turn_order_strings)
