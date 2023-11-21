extends TextureButton

class_name newcard

var spawn_loc: Vector2
var hex_color: int

func _init(spawn_loc = Vector2(0, 0), hex_color = 004800) -> void:
	var color = Color.hex(hex_color)
	set_modulate(color)
	position = spawn_loc

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
