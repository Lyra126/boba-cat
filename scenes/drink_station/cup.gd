extends Node2D

var selected
var offset = Vector2.ZERO
var rest_point
var rest_nodes = []
var tea_droppable = false
var body_ref
var target_position
var pouring_milk
var pour_milk_left = false
var pour_milk_right = true
var cup_droppable_position = Vector2(800,173)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_cup_pick_up_input_event(viewport, event, shape_idx):
	
	if Input.is_action_just_pressed("click") and not global.SomethingBeingClickedRn:
		selected = true
		global.SomethingBeingClickedRn = true;
		offset = get_global_mouse_position() - global_position
		
func _physics_process(delta):
	if selected:
		target_position = get_global_mouse_position() - offset
		global_position = lerp(global_position, target_position, 15 * delta) # Smooth animation during dragging
		#look_at(get_local_mouse_position())
		if global_position.y < -50:
			scale = Vector2(0.75, 0.75)
		else:
			scale = Vector2(1, 1)
	#else:
		##global_position = lerp(global_position, Vector2.ZERO, 10 * delta)
		#rotation = lerp_angle(rotation, 0, 10 * delta)
		
func _input(event):
	if selected:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if tea_droppable:
					print("placeholder")
				else:
					if global_position.x < -600 and global_position.x > -1000 and global_position.y < 100 and global_position.y > -500:
						global_position.x = -814.25
						global_position.y = 50
						scale = Vector2(0.5, 0.5)
					else:
						global_position = lerp(global_position, Vector2.ZERO, 1)
					selected = false
					global.SomethingBeingClickedRn = false;
					
