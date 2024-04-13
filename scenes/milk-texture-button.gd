extends TextureButton

var dragging = false
var offset = Vector2.ZERO
var initial_position : Vector2
var body_ref: Node
var initial_rotation = 0  # Save the initial rotation

var cup_droppable = false
var base_droppable = false

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position
	initial_rotation = rotation_degrees

# Smooth dragging operation
func _process(delta):
	if dragging:
		var target_position = get_global_mouse_position() - offset
		position = position.lerp(target_position, 15 * delta) # Smooth animation during dragging

# Detect mouse button down to initiate dragging
func _on_button_down():
	dragging = true
	offset = get_global_mouse_position() - global_position

# Handle the release of the mouse button, determine drop behavior
func _on_button_up():
	dragging = false
	if cup_droppable:
		#animate_to_position(body_ref.global_position)
		print("animation")
	elif base_droppable:
		animate_to_position(body_ref.global_position + calculate_offset())
	else:
		animate_to_position(initial_position)  # Snap back if not in a droppable area

func calculate_offset():
	var margin = 10 # Margin in pixels to avoid glitching at the edge
	return Vector2(margin, margin)
	
# Animate movement to the specified target position using tweens
func animate_to_position(target_pos: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", target_pos, 0.3)

# Handle entering droppable areas
func _on_area_2d_body_entered(body: StaticBody2D):
	if body.is_in_group('cup_drop'):
		cup_droppable = true
		rotation_degrees = lerp_angle(rotation_degrees, deg_to_rad(280), 35)
		body_ref = body
		
	elif body.is_in_group('base_milk'):
		base_droppable = true
		body_ref = body

# Handle exiting droppable areas
func _on_area_2d_body_exited(body):
	if body == body_ref:
		cup_droppable = false
		base_droppable = false
		rotation_degrees = initial_rotation  # Reset rotation

# Scale changes on mouse hover to give visual feedback
func _on_mouse_entered():
	scale = Vector2(1.05, 1.05)

func _on_mouse_exited():
	scale = Vector2(1, 1)
