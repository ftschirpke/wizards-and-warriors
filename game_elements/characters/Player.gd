extends CharacterBody2D
class_name PlayerCharacter

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer
@onready var ui: PlayerUI = $PlayerUIOverlay

@onready var burn_draw_button: Button = $PlayerUIOverlay/PlayerUIMargin/PlayerUIFooterRight/BurnDrawButton
@onready var discard_draw_button: Button = $PlayerUIOverlay/PlayerUIMargin/PlayerUIFooterRight/DiscardDrawButton
@onready var discard_button: Button = $PlayerUIOverlay/PlayerUIMargin/PlayerUIFooterRight/DiscardButton

var data: PlayerData
var is_active: bool: set = _set_is_active

const SPEED: float = 100.0
const CHAR_SPEED: int = 10
const HP_MAX: int = 30

var target_loc := Vector2(0, 0)
var current_loc: Vector2

var vel: float
var move: bool = false

var char_speedtemp: int
var hp_current: int: set = _set_hp_current

var draw_count: int = 3

func _init() -> void:
    data = PlayerData.new()

signal hp_changed(new_hp: int, max_hp: int)

func _set_hp_current(value: int) -> void:
    hp_changed.emit(value, HP_MAX)
    hp_current = value

func _set_is_active(value: bool) -> void:
    ui.visible = value
    is_active = value
    if is_active:
        start_turn()

func _ready() -> void:
    data.deck.hand_changed.connect(ui._on_hand_changed)
    burn_draw_button.pressed.connect(func(): data.deck.deal_and_burn_overflow(draw_count))
    discard_draw_button.pressed.connect(func(): data.deck.discard_and_deal(draw_count))
    discard_button.pressed.connect(data.deck.discard_hand)
    is_active = false
    hp_current = HP_MAX

func _physics_process(delta: float) -> void:
    if not is_active:
        return
    var dir = to_local(nav_agent.get_next_path_position()).normalized()
    velocity = dir * SPEED * delta * 50
    if (position - target_loc).length() <= (velocity * delta).length() and move:
        move = false
        position = target_loc
    elif char_speedtemp == 0:
        move = false

    if move:
        move_and_slide()

func start_turn() -> void:
    data.deck.deal_and_burn_overflow(draw_count)

func getpath() -> void:
    nav_agent.target_position = target_loc
    move = false

func _unhandled_input(event: InputEvent) -> void:
    if is_active and event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            target_loc = get_global_mouse_position()
            getpath()

        if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
            move = true
            char_speedtemp = CHAR_SPEED
            timer.start()

func _on_timer_timeout():
    if move:
        char_speedtemp = char_speedtemp - 1
        print(char_speedtemp)
        if char_speedtemp == 0:
            timer.stop()

func attack() -> void:
    pass
