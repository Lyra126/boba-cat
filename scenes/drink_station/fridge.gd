extends Node2D
@onready var semi_open = $FridgeSemiopen
@onready var closed = $FridgeClosed
@onready var open = $FridgeOpen

var clicked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	closed.show()
	open.hide()
	semi_open.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_mouse_entered():
	if not clicked:
		semi_open.show()
		closed.hide()
		pass

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			open.show()
			closed.hide()
			semi_open.hide()
			clicked = true
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			open.hide()
			closed.show()
			clicked = false

func _on_area_2d_mouse_exited():
	if not clicked:
		closed.show()
		semi_open.hide()
	#open.hide()

