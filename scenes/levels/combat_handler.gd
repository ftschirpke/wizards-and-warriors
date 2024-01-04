class_name CombatHandler extends Object

var combatants: Array # either PlayerData or EnemyData (not implemented yet)
var current: int = -1

var round_number: int = -1

signal player_turn(id: int)
signal enemy_turn(id: int)
signal change_turn_order_ui(turn_order: Array[String])
signal change_round_counter_ui(round_number: int)

func _init(players_data: Array, enemies_data: Array) -> void:
    self.combatants = players_data
    self.combatants.append_array(enemies_data)
    self.combatants.sort_custom(func(a, b) -> bool: return a.speed >= b.speed)

func start_combat() -> void:
    next_round()

func next_round() -> void:
    current = -1
    round_number += 1
    change_round_counter_ui.emit(round_number)

    next_turn()

func next_turn() -> void:
    current += 1
    if current >= combatants.size(): # round finished
        next_round()
        return

    var current_data = combatants[current]
    if current_data is PlayerData:
        player_turn.emit(current_data.id)
    # elif current_data is EnemyData: # TODO: implement enemies
    #    enemy_turn.emit(current_data.id)

    var combatant_names = combatants.slice(current).map(func(combatant) -> String: return combatant.name)
    change_turn_order_ui.emit(combatant_names)

func reevaluate_turn_order() -> void:
    # TODO
    pass
