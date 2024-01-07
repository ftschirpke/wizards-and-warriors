class_name PlayerData extends Object

var id: int
var name: String
var speed: int
var hp: int

var deck: Deck

func _init(new_id: int, new_name: String, new_speed: int, new_hp: int) -> void:
    id = new_id
    name = new_name
    speed = new_speed
    hp = new_hp
    deck = Deck.new()