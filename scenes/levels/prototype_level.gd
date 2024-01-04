extends Node2D

var player_scene: = preload("res://game_elements/characters/player.tscn")

@onready var camera: Camera2D = $Camera2D

@onready var round_counter_label: Label = $UIOverlay/UIMargin/UIHeaderMiddle/RoundCounterLabel
@onready var header_middle_separator: VSeparator = $UIOverlay/UIMargin/UIHeaderMiddle/HeaderMiddleSeparator
@onready var turn_order_label: Label = $UIOverlay/UIMargin/UIHeaderMiddle/TurnOrderLabel

var players: Array
var current_player: PlayerCharacter = null: set = _set_current_player
var combat_handler: CombatHandler = null

func _on_player_turn(player_id: int) -> void:
    for player in players:
        if player.data.id == player_id:
            current_player = player
            return

func _set_current_player(player: PlayerCharacter) -> void:
    if current_player != null:
        current_player.is_active = false
    _follow_player(player)
    current_player = player
    current_player.is_active = true

func _create_player_at(pos: Vector2, player_data: PlayerData) -> void:
    var new_player: PlayerCharacter = player_scene.instantiate()
    new_player.set_player_data(player_data)
    add_child(new_player)
    assert(combat_handler != null)
    new_player.ui.end_turn_button.pressed.connect(combat_handler.next_turn)
    players.append(new_player)
    new_player.position = pos
    new_player.is_active = false

func _follow_player(player: PlayerCharacter) -> void:
    if current_player == player:
        return
    elif current_player == null:
        get_node("CameraFollow").reparent(player)
    else:
        current_player.get_node("CameraFollow").reparent(player)
    var new_location: RemoteTransform2D = player.get_node("CameraFollow")
    new_location.remote_path = new_location.get_path_to(camera)
    new_location.position = Vector2.ZERO

func _ready() -> void:
    round_counter_label.visible = false
    header_middle_separator.visible = false
    turn_order_label.visible = true

    var players_data: Array = [
        PlayerData.new(0, "Player1", 10, 30),
        PlayerData.new(1, "Player2", 12, 40),
        PlayerData.new(2, "Player3", 8, 25),
    ]
    var positions = [
        Vector2(200, 200), Vector2(300, 200), Vector2(500, 200),
    ]

    combat_handler = CombatHandler.new(players_data.duplicate(true), [])
    combat_handler.change_round_counter_ui.connect(round_counter_label._on_change_round_counter_ui)
    combat_handler.change_turn_order_ui.connect(turn_order_label._on_change_turn_order_ui)
    combat_handler.player_turn.connect(_on_player_turn)
    for i in range(3):
        _create_player_at(positions[i], players_data[i])
    combat_handler.start_combat()
    round_counter_label.visible = true
    header_middle_separator.visible = true
