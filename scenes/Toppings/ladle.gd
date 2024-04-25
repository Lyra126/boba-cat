extends Node2D

@onready var ladle_area = $"../LadleHanger/ladle body"
@onready var sprite = $Ladle
@onready var anim = $Ladle/AnimatedSprite2D
var ladle_dalgona = preload("res://assets/toppings_station/assets/ladle_dalgona.png")
var ladle_fruit_jelly = preload("res://assets/toppings_station/assets/ladle_fruit_jelly.png")
var ladle_popping_boba = preload("res://assets/toppings_station/assets/ladle_popping_boba.png")
var ladle_boba_pearls = preload("res://assets/toppings_station/assets/ladle_boba_pearls.png")
var ladle_strawberries = preload("res://assets/toppings_station/assets/ladle_strawberries.png")

var selected = false
var off_set = Vector2.ZERO
var target_position
var in_ladle_area
var in_toppings
var popping_boba
var boba_pearls
var strawberries
var dalgona
var fruit_jelly
var cup_droppable

var popping_boba_ladle
var boba_pearls_ladle
var strawberries_ladle
var dalgona_ladle
var fruit_jelly_ladle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(global.SomethingBeingClickedRn)

func _on_ladle_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("click") and not global.SomethingBeingClickedRn:
		selected = true
		global.SomethingBeingClickedRn = true;
		off_set = get_global_mouse_position() - global_position
		
	if Input.is_action_pressed("right_click"):
		selected = false
		global.SomethingBeingClickedRn = false;


func _input(event):
	if selected:
		global.SomethingBeingClickedRn = true
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				var mouse_position = get_viewport().get_mouse_position()
				if popping_boba:
					global.SomethingBeingClickedRn = true
					sprite.set_texture(ladle_popping_boba)
					popping_boba_ladle = true
						
				elif dalgona:
					global.SomethingBeingClickedRn = true
					sprite.set_texture(ladle_dalgona)
					dalgona_ladle = true
					
				elif fruit_jelly:
					global.SomethingBeingClickedRn = true
					sprite.set_texture(ladle_fruit_jelly)
					fruit_jelly = true
					
				elif strawberries:
					global.SomethingBeingClickedRn = true
					sprite.set_texture(ladle_strawberries)
					strawberries_ladle = true
					
				elif boba_pearls:
					global.SomethingBeingClickedRn = true
					sprite.set_texture(ladle_boba_pearls)
					boba_pearls_ladle = true
					
				elif cup_droppable:
					print("POOP")
					global.SomethingBeingClickedRn = true
					if popping_boba_ladle:
						# adding into the cup
						global.toppings_inserted.append("popping-boba")
						
					elif boba_pearls_ladle:
						global.toppings_inserted.append("boba-pearls")
						
					elif dalgona_ladle:
						global.toppings_inserted.append("dalgona-chunks")
					
					elif fruit_jelly_ladle:
						global.toppings_inserted.append("fruit-jelly")
						
					elif strawberries_ladle:
						global.toppings_inserted.append("strawberry-slices")
		
				#else:
					#selected = false
					#smooth_back(get_physics_process_delta_time())
					#global.SomethingBeingClickedRn = false
					
func smooth_back(delta):
	global_position = lerp(global_position, Vector2.ZERO, 10 * delta)

func handle_toppings_pick():
	pass
	
func _physics_process(delta):
	if selected:
		target_position = get_global_mouse_position() - off_set
		global_position = lerp(global_position, target_position, 15 * delta) # Smooth animation during dragging
		#look_at(get_global_mouse_position())
	else:
		global_position = lerp(global_position, ladle_area.global_position, 10 * delta)
		rotation = lerp_angle(rotation, 150.40, 10 * delta)


func _on_scoopable_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('cup_drop'):
		cup_droppable = true
		print('bro')
		
	if body.is_in_group('ladle_area'):
		in_ladle_area = true
		
	if body.is_in_group('popping_boba'):
		popping_boba = true
		
	if body.is_in_group('fruit_jelly'):
		fruit_jelly = true
		
	if body.is_in_group('strawberry_slices'):
		strawberries = true
		
	if body.is_in_group('dalgona_chunks'):
		dalgona = true
		
	if body.is_in_group('boba_balls'):
		boba_pearls = true


func _on_scoopable_area_body_exited(body: Node2D) -> void:
	if body.is_in_group('cup_drop'):
		cup_droppable = false
		
	if body.is_in_group('ladle_area'):
		in_ladle_area = false
		
	if body.is_in_group('popping_boba'):
		popping_boba = false
		
	if body.is_in_group('fruit_jelly'):
		fruit_jelly = false
		
	if body.is_in_group('strawberry_slices'):
		strawberries = false
		
	if body.is_in_group('dalgona_chunks'):
		dalgona = false
		
	if body.is_in_group('boba_balls'):
		boba_pearls = false
