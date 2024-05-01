extends Node2D

@onready var tongs_place = $"../tongs_closed_place"
@onready var tongs_sprite = $"tongs img"
@onready var c1 = $"../stuff on tray/cookie1"
@onready var c2 = $"../stuff on tray/cookie2"
@onready var c3 = $"../stuff on tray/cookie3"
@onready var c4 = $"../stuff on tray/cookie4"
@onready var c5 = $"../stuff on tray/cookie5"

var cat_cookie_sprite = preload("res://assets/final_station/cookie_cat.png")
var sugar_cookie_sprite = preload("res://assets/final_station/sugar_cookie.png")
var choco_cookie_sprite = preload("res://assets/final_station/choco_cookie.png")

var tongs_closed
var selected
var off_set
var target_position
var cat_cookie
var chocolate_cookie
var sugar_cookie
var tray_droppable
#var layer = 0

var cat_cookie_tongs
var chocolate_cookie_tongs
var sugar_cookie_tongs

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.get_cookies(c1,c2,c3,c4,c5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and not global.SomethingBeingClickedRn:
			$"../tong".play()
			selected = true
			tongs_sprite.texture = preload("res://assets/final_station/tongs/tongs_opened.png")
			global.SomethingBeingClickedRn = true;
			off_set = get_global_mouse_position() - global_position
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			$"../tong".play()
			selected = false
			tongs_sprite.texture = preload("res://assets/final_station/tongs/tongs_closed.png")
			global.SomethingBeingClickedRn = false;

func _input(event):
	if selected:
		global.SomethingBeingClickedRn = true
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				var mouse_position = get_viewport().get_mouse_position()
				if cat_cookie:
					tongs_sprite.texture = preload("res://assets/final_station/tongs/tongs_cat.png")
					cat_cookie_tongs = true
					chocolate_cookie_tongs = false
					sugar_cookie_tongs = false
				if chocolate_cookie:
					tongs_sprite.texture = preload("res://assets/final_station/tongs/tongs_choco.png")
					cat_cookie_tongs = false
					chocolate_cookie_tongs = true
					sugar_cookie_tongs = false
				if sugar_cookie:
					tongs_sprite.texture = preload("res://assets/final_station/tongs/tongs_sugar.png")
					cat_cookie_tongs = false
					chocolate_cookie_tongs= false
					sugar_cookie_tongs= true
				elif tray_droppable:
					if final_station_global.cookie_layers < 5:
						if cat_cookie_tongs:
							handle_cookie_layers(final_station_global.cookie_layers, cat_cookie_sprite)
							final_station_global.cookie_layers += 1
							$"../dropCookie".play()
							cat_cookie_tongs = false
							tongs_sprite.texture = preload("res://assets/final_station/tongs/tongs_opened.png")
							global.cookies_added.append("catCookie")
							global.playerOrder.append("cat-cookie")
							global.cookies_sprites.append("res://assets/final_station/cookie_cat.png")
						
						
						elif sugar_cookie_tongs:
							$"../dropCookie".play()
							handle_cookie_layers(final_station_global.cookie_layers, sugar_cookie_sprite)
							final_station_global.cookie_layers += 1
							sugar_cookie_tongs = false
							tongs_sprite.texture = preload("res://assets/final_station/tongs/tongs_opened.png")
							global.cookies_added.append("sugarCookie")
							global.playerOrder.append("sugar-cookie")
							global.cookies_sprites.append("res://assets/final_station/sugar_cookie.png")
							
						elif chocolate_cookie_tongs:
							$"../dropCookie".play()
							handle_cookie_layers(final_station_global.cookie_layers, choco_cookie_sprite)
							final_station_global.cookie_layers += 1
							chocolate_cookie_tongs = false
							tongs_sprite.texture = preload("res://assets/final_station/tongs/tongs_opened.png")
							global.cookies_added.append("chocolateCookie")
							global.playerOrder.append("chocolate-cookie")
							global.cookies_sprites.append("res://assets/final_station/choco_cookie.png")
							
func handle_cookie_layers(layer, cookie):
	if final_station_global.cookie_layers == 0:
		c1.texture = cookie
	elif final_station_global.cookie_layers == 1:
		c2.texture = cookie
	elif final_station_global.cookie_layers == 2:
		c3.texture = cookie
	elif final_station_global.cookie_layers == 3:
		c4.texture = cookie
	elif final_station_global.cookie_layers == 4:
		c5.texture = cookie
					
func _physics_process(delta):
	if selected:
		target_position = get_global_mouse_position() - off_set
		global_position = lerp(global_position, target_position, 15 * delta) # Smooth animation during dragging
	else:
		global_position = lerp(global_position, tongs_place.global_position, 10 * delta)
		rotation = lerp_angle(rotation, 0, 10 * delta)

func _on_tongs_grab_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('cat-cookie') or body.is_in_group('cat-cookie-2'):
		cat_cookie = true
		
	if body.is_in_group('chocolate-cookie') or body.is_in_group('chocolate-cookie-2'):
		chocolate_cookie = true

	if body.is_in_group('sugar-cookie'):
		sugar_cookie = true
		
	if body.is_in_group('tray'):
		tray_droppable = true
		
func _on_tongs_grab_area_body_exited(body: Node2D) -> void:
	if body.is_in_group('cat-cookie'):
		cat_cookie = false
	if body.is_in_group('chocolate-cookie'):
		chocolate_cookie = false
	if body.is_in_group('sugar-cookie'):
		sugar_cookie = false
	if body.is_in_group('tray'):
		tray_droppable = false

func _on_trash_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.pressed:
				c1.texture = null
				c2.texture = null
				c3.texture = null
				c4.texture = null
				c5.texture = null
