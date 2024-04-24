extends Node2D

@onready var ladle_area = $"../ladle area"


var selected
var off_set = Vector2.ZERO
var target_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ladle_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click") and not global.SomethingBeingClickedRn:
		selected = true
		global.SomethingBeingClickedRn = true;
		off_set = get_global_mouse_position() - global_position
	elif Input.is_action_just_pressed("click"):	
		print(get_global_mouse_position())


func _physics_process(delta):
	if selected:
		target_position = get_global_mouse_position() - off_set
		global_position = lerp(global_position, target_position, 15 * delta) # Smooth animation during dragging
		#look_at(get_global_mouse_position())
	else:
		global_position = lerp(global_position, ladle_area.global_position, 10 * delta)
		rotation = lerp_angle(rotation, 150.40, 10 * delta)
