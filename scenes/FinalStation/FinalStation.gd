extends Node2D

var cup_in_attach_lid = false
@onready var openTrash = preload("res://assets/buttons/openTrash.png")
@onready var closeTrash = preload("res://assets/buttons/closeTrash.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if not global.hasCup:
		$cup.hide()
	if global.order != []:
		$TextureButton.visible = true
		

func _on_submit_order_pressed():
	if global.order != []:
		$button.play()
		get_tree().change_scene_to_file("res://scenes/Rate/rate.tscn")
	else:
		print("You haven't made their order yet!")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/drink_station/liquid_station.tscn")


func _on_trash_mouse_exited() -> void:
	$trash.texture = closeTrash


func _on_trash_mouse_entered() -> void:
	$trash.texture = openTrash


func _on_trash_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.pressed:
				$trashCan.play()
				$trash.texture = closeTrash
				print("cup has been deleted")
				$cup.visible = false
				global.hasCup = false
				global.reset_drink()
				global.playerOrder = []

func _on_texture_button_pressed() -> void:
	$button.play()
	$OrderForm.visible = true
	$close.visible = true
	$OrderForm/Label.visible = true
	$OrderForm/Label.set_text(global.orderPaper)


func _on_close_pressed() -> void:
	$button.play()
	$OrderForm.visible = false
	$OrderForm/Label.visible = false
	$close.visible = false
