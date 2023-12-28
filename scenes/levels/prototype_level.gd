extends Node2D

var player_scene: = preload("res://game_elements/characters/player.tscn")

@onready var camera: Camera2D = $Camera2D

var players: Array
var current_player: PlayerCharacter: set = _set_current_player

func _set_current_player(player: PlayerCharacter) -> void:
    if current_player != null:
        current_player.is_active = false
    _follow_player(player)
    current_player = player
    current_player.is_active = true

func _create_player_at(pos: Vector2) -> void:
    var new_player: PlayerCharacter = player_scene.instantiate()
    add_child(new_player)
    players.append(new_player)
    players.back().position = pos

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
    _create_player_at(Vector2(200, 200))
    _create_player_at(Vector2(300, 200))
    _create_player_at(Vector2(500, 200))
    current_player = players[0]
