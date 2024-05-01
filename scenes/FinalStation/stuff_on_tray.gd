extends Node2D

@onready var straw = $straw

var straw_p = preload("res://assets/final_station/straw_p.png")
var straw_y = preload("res://assets/final_station/straw_y.png")
var straw_g = preload("res://assets/final_station/straw_g.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	straw.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_straw_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.pressed:
				$"../straw".play()
				straw.show()
				global.hasStraw = true
				randomize_straw(straw)
				
func randomize_straw(sprite):
	var rand = RandomNumberGenerator.new()
	var num = rand.randi_range(1, 3)
	if num == 1:
		sprite.set_texture(straw_p)
		global.straw_sprite = 'pink straw'
	elif num == 2:
		sprite.set_texture(straw_y)
		global.straw_sprite = 'yellow straw'
	elif num == 3:
		sprite.set_texture(straw_g)
		global.straw_sprite = 'green straw'
	else:
		print("how is that possible...i set the random integers to 1 and 3. you cannot possibly get another number....WHAT!!!")


func _on_trash_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.pressed:
				straw.hide()
				global.hasStraw = false
