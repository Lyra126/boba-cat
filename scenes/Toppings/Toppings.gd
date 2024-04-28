extends Node2D
@onready var getCup = preload("res://assets/toppings_station/assets/getCupDispenser.png")
@onready var cupDispenser = preload("res://assets/toppings_station/assets/cupDispenser.png")
@onready var openTrash = preload("res://assets/buttons/openTrash.png")
@onready var closeTrash = preload("res://assets/buttons/closeTrash.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	if not global.hasCup:
		$Cup.hide()
	if global.order != []:
		$TextureButton.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/drink_station/liquid_station.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/customer_line/customer_line.tscn")

func _on_area_2d_mouse_entered() -> void:
	$CupDispenser.texture = getCup


func _on_area_2d_mouse_exited() -> void:
	$CupDispenser.texture = cupDispenser


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.pressed:
				$CupDispenser.texture = cupDispenser
				print("cup has been selected")
				$Cup.visible = true
				global.hasCup = true

func _on_trash_mouse_exited() -> void:
	$trash.texture = closeTrash

func _on_trash_mouse_entered() -> void:
	$trash.texture = openTrash

func _on_trash_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.pressed:
				$trash.texture = closeTrash
				print("cup has been deleted")
				$Cup.visible = false
				global.hasCup = false
				global.reset_drink()

func _on_close_pressed() -> void:
	print("test")
	$OrderForm.visible = false
	$OrderForm/Label.visible = false
	$close.visible = false


func _on_texture_button_pressed() -> void:
	$OrderForm.visible = true
	$close.visible = true
	var orderText = ""
	for item in global.order:
		orderText += str(item) + "\n"
	print(orderText)
	$OrderForm/Label.visible = true
	$OrderForm/Label.set_text(orderText)

