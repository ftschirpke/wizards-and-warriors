class_name Deck extends Object

const DEFAULT_CARD_ATTRIBUTES: Array[int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]

var playing_card_scene: PackedScene = preload("res://game_elements/cards/playing_card.tscn")

var deck: Array # Array[PlayingCard]
var grave: Array # Array[PlayingCard]
var hand: Array # Array[PlayingCard]

static var hand_maximum: int = 5

signal hand_changed(new_hand: Array, new_deck_count: int, new_grave_count: int)

func _init(card_attributes: Array[int] = DEFAULT_CARD_ATTRIBUTES) -> void:
    deck = card_attributes.map(_instantiate_card)
    shuffle()

func _instantiate_card(attribute: int) -> PlayingCard:
    var card: PlayingCard = playing_card_scene.instantiate()
    card.card_attribute = attribute
    return card

func notify_about_hand_change() -> void:
    hand_changed.emit(hand, deck.size(), grave.size())

func cycle_grave() -> void:
    deck.append_array(grave)
    shuffle()
    grave.clear()

func discard_hand() -> void:
    grave.append_array(hand)
    hand.clear()
    notify_about_hand_change()

func _give_next_in_deck() -> PlayingCard:
    if deck.is_empty():
        cycle_grave()
    return deck.pop_back()

func _deal(count: int) -> void:
    for i in range(count):
        hand.append(_give_next_in_deck())
    notify_about_hand_change()

func discard_and_deal(count: int) -> void:
    discard_hand()
    _deal(count)
    notify_about_hand_change()

func deal_and_burn_overflow(count: int) -> void:
    var deal_count: int = min(count, hand_maximum - hand.size())
    _deal(deal_count)
    for i in range(count - deal_count):
        grave.append(_give_next_in_deck())
    notify_about_hand_change()

func shuffle() -> void:
    deck.shuffle()
