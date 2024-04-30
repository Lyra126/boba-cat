extends Node2D

@onready var ladle_area = $"../LadleHanger/ladle body"
@onready var sprite = $Ladle
@onready var anim = $Ladle/AnimatedSprite2D
@onready var t5 = $"../Cup/stuff_inside_cup/Polygon2D/toppings-5"
@onready var t4 = $"../Cup/stuff_inside_cup/Polygon2D/toppings-4"
@onready var t3 = $"../Cup/stuff_inside_cup/Polygon2D/toppings-3"
@onready var t2 = $"../Cup/stuff_inside_cup/Polygon2D/toppings-2"
@onready var t1 = $"../Cup/stuff_inside_cup/Polygon2D/toppings-1"

var ladle = preload("res://assets/toppings_station/assets/ladle.png")
var ladle_dalgona = preload("res://assets/toppings_station/assets/ladle_dalgona.png")
var ladle_fruit_jelly = preload("res://assets/toppings_station/assets/ladle_fruit_jelly.png")
var ladle_popping_boba = preload("res://assets/toppings_station/assets/ladle_popping_boba.png")
var ladle_boba_pearls = preload("res://assets/toppings_station/assets/ladle_boba_pearls.png")
var ladle_strawberries = preload("res://assets/toppings_station/assets/ladle_strawberries.png")
var boba_topping = preload("res://assets/toppings_station/assets/toppings-in-cup/boba-pearls.png")
var dalgona_topping = preload("res://assets/toppings_station/assets/toppings-in-cup/dalgona-chunks.png")
var fruitJelly_topping = preload("res://assets/toppings_station/assets/toppings-in-cup/fruit-jelly.png")
var poppingBoba_topping = preload("res://assets/toppings_station/assets/toppings-in-cup/popping-boba.png")
var strawberrySlices_topping = preload("res://assets/toppings_station/assets/toppings-in-cup/strawberry-slices.png")

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
	global.SomethingBeingClickedRn = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(global.SomethingBeingClickedRn)
	#print(layer)
	pass

func _on_ladle_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and not global.SomethingBeingClickedRn:
	#Input.is_action_pressed("click") and not global.SomethingBeingClickedRn:
			selected = true
			#print('bruh')
			global.SomethingBeingClickedRn = true;
			off_set = get_global_mouse_position() - global_position
		
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			selected = false
			global.SomethingBeingClickedRn = false;


func _input(event):
	if selected and global.hasCup:
		global.SomethingBeingClickedRn = true
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				var mouse_position = get_viewport().get_mouse_position()
				if popping_boba:
					$"../pickToppingAudio".play()
					global.SomethingBeingClickedRn = true
					sprite.set_texture(ladle_popping_boba)
					popping_boba_ladle = true
					boba_pearls_ladle = false
					strawberries_ladle = false
					dalgona_ladle = false
					fruit_jelly_ladle = false
						
				elif dalgona:
					$"../pickToppingAudio".play()
					global.SomethingBeingClickedRn = true
					sprite.set_texture(ladle_dalgona)
					dalgona_ladle = true
					popping_boba_ladle = false
					boba_pearls_ladle = false
					strawberries_ladle = false
					fruit_jelly_ladle = false
					
				elif fruit_jelly:
					$"../pickToppingAudio".play()
					global.SomethingBeingClickedRn = true
					sprite.set_texture(ladle_fruit_jelly)
					fruit_jelly_ladle = true
					popping_boba_ladle = false
					boba_pearls_ladle = false
					strawberries_ladle = false
					dalgona_ladle = false
					
				elif strawberries:
					$"../pickToppingAudio".play()
					global.SomethingBeingClickedRn = true
					sprite.set_texture(ladle_strawberries)
					strawberries_ladle = true
					popping_boba_ladle = false
					boba_pearls_ladle = false
					dalgona_ladle = false
					fruit_jelly_ladle = false
					
				elif boba_pearls:
					$"../pickToppingAudio".play()
					global.SomethingBeingClickedRn = true
					sprite.set_texture(ladle_boba_pearls)
					boba_pearls_ladle = true
					popping_boba_ladle = false
					dalgona_ladle = false
					fruit_jelly_ladle = false
					strawberries_ladle = false
					
				elif cup_droppable:
					global.SomethingBeingClickedRn = true
					if toppings_station_global.toppings_layers < 5 and not global.hasLid:
						if popping_boba_ladle:
							handle_layer(toppings_station_global.toppings_layers, poppingBoba_topping)
							global.playerOrder.append("popping-boba")
							global.toppings_inserted.append("poppingBoba")
							global.topping_sprites.append("res://assets/toppings_station/assets/toppings-in-cup/popping-boba.png")
							toppings_station_global.toppings_layers += 1
							popping_boba_ladle = false
							sprite.set_texture(ladle)
							
						elif boba_pearls_ladle:
							global.playerOrder.append("boba")
							global.toppings_inserted.append("bobaBalls")
							handle_layer(toppings_station_global.toppings_layers, boba_topping)
							global.topping_sprites.append("res://assets/toppings_station/assets/toppings-in-cup/boba-pearls.png")
							toppings_station_global.toppings_layers += 1
							boba_pearls_ladle = false
							sprite.set_texture(ladle)
							
						elif dalgona_ladle:
							global.playerOrder.append("dalgona-chunks")
							global.toppings_inserted.append("dalgonaChunks")
							handle_layer(toppings_station_global.toppings_layers, dalgona_topping)
							global.topping_sprites.append("res://assets/toppings_station/assets/toppings-in-cup/dalgona-chunks.png")
							toppings_station_global.toppings_layers += 1
							dalgona_ladle = false
							sprite.set_texture(ladle)
							
						elif fruit_jelly_ladle:
							global.playerOrder.append("fruit-jelly")
							global.toppings_inserted.append("fruitJelly")
							handle_layer(toppings_station_global.toppings_layers, fruitJelly_topping)
							toppings_station_global.toppings_layers += 1
							global.topping_sprites.append("res://assets/toppings_station/assets/toppings-in-cup/fruit-jelly.png")
							fruit_jelly_ladle = false
							sprite.set_texture(ladle)
							
						elif strawberries_ladle:
							global.playerOrder.append("strawberries")
							global.toppings_inserted.append("strawberrySlices")
							handle_layer(toppings_station_global.toppings_layers, strawberrySlices_topping)
							toppings_station_global.toppings_layers += 1
							global.topping_sprites.append("res://assets/toppings_station/assets/toppings-in-cup/strawberry-slices.png")
							strawberries_ladle = false
							sprite.set_texture(ladle)
							
					else:
						selected = false
						global.SomethingBeingClickedRn = false
						#print(global.toppings_inserted)

				#else:
					#selected = false
					#smooth_back(get_physics_process_delta_time())
					#global.SomethingBeingClickedRn = false
					
func smooth_back(delta):
	global_position = lerp(global_position, Vector2.ZERO, 10 * delta)

func handle_layer(layer, toppings):
	if toppings_station_global.toppings_layers == 0:
		t1.set_texture(toppings)
		
	elif toppings_station_global.toppings_layers == 1:
		t2.set_texture(toppings)
		
	elif toppings_station_global.toppings_layers == 2:
		t3.set_texture(toppings)
		
	elif toppings_station_global.toppings_layers == 3:
		t4.set_texture(toppings)
		
	elif toppings_station_global.toppings_layers == 4:
		t5.set_texture(toppings)
		
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


func _on_trash_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.pressed:
				t5.set_texture(null)
				t4.set_texture(null)
				t3.set_texture(null)
				t2.set_texture(null)
				t1.set_texture(null)
				$"../Cup/stuff_inside_cup/Polygon2D/liquid_sprite".set_texture(null)
				
