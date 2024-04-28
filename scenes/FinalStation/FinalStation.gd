extends Node2D

var cup_in_attach_lid = false
@onready var openTrash = preload("res://assets/buttons/openTrash.png")
@onready var closeTrash = preload("res://assets/buttons/closeTrash.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if not global.hasCup:
		$cup.hide()
	if global.order.empty() == 0:
		$TextureButton.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_submit_order_pressed():
	get_tree().change_scene_to_file("res://scenes/Rate/rate.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/drink_station/liquid_station.tscn")


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.


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
				$cup.visible = false
				global.hasCup = false
				global.reset_drink()


func _on_texture_button_pressed() -> void:
	$order.visible = true
	$close.visible = true
	var orderText = ""
	for item in global.order:
		orderText += str(item) + "\n"
	print(orderText)
	$order/Label.visible = true
	$order/Label.set_text(orderText)
	

func _on_close_pressed() -> void:
	print("test")
	$order.visible = false
	$order/Label.visible = false
	$close.visible = false

