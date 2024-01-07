class_name PlayerCharacter extends CharacterBody2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer
@onready var ui: PlayerUI = $PlayerUIOverlay

@onready var burn_draw_button: Button = $PlayerUIOverlay/PlayerUIMargin/PlayerUIFooterRight/BurnDrawButton
@onready var discard_draw_button: Button = $PlayerUIOverlay/PlayerUIMargin/PlayerUIFooterRight/DiscardDrawButton
@onready var discard_button: Button = $PlayerUIOverlay/PlayerUIMargin/PlayerUIFooterRight/DiscardButton

var data: PlayerData = null
var is_active: bool = false:
    set = _set_is_active

const SPEED: float = 100.0
const CHAR_SPEED: int = 10
const HP_MAX: int = 30

var target_loc: Vector2
var current_loc: Vector2

var vel: float
var move: bool = false

var char_speedtemp: int = CHAR_SPEED

var hp_current: int = HP_MAX:
    set = _set_hp_current

var draw_count: int = 3

signal hp_changed(new_hp: int, max_hp: int)

func set_player_data(player_data: PlayerData) -> void:
    assert(data == null)
    data = player_data

func _set_hp_current(value: int) -> void:
    hp_changed.emit(value, HP_MAX)
    hp_current = value

func _set_is_active(value: bool) -> void:
    ui.visible = value
    is_active = value
    nav_agent.debug_enabled = is_active
    if is_active:
        print("Current player's name: %s" % data.name)
        print("Current player's position: %v" % position)
        start_turn()
    else:
        target_loc = position
        stop_and_get_path()

func _ready() -> void:
    assert(data != null)
    data.deck.hand_changed.connect(ui._on_hand_changed)
    burn_draw_button.pressed.connect(func(): data.deck.deal_and_burn_overflow(draw_count))
    discard_draw_button.pressed.connect(func(): data.deck.discard_and_deal(draw_count))
    discard_button.pressed.connect(data.deck.discard_hand)
    
    hp_changed.connect(ui.hp_label._on_player_hp_changed)
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

func stop_and_get_path() -> void:
    nav_agent.target_position = target_loc
    move = false

func _unhandled_input(event: InputEvent) -> void:
    if is_active and event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
            target_loc = get_global_mouse_position()
            stop_and_get_path()

        if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
            move = true
            timer.start()

func _on_timer_timeout():
    if move:
        char_speedtemp = char_speedtemp - 1
        print(char_speedtemp)
        if char_speedtemp == 0:
            timer.stop()

func attack() -> void:
    pass
