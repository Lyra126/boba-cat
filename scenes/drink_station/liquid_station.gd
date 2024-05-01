extends Node2D
@onready var openTrash = preload("res://assets/buttons/openTrash.png")
@onready var closeTrash = preload("res://assets/buttons/closeTrash.png")
@onready var anim = $"cup/liquid-in-cup/Polygon2D/liquid_animations"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Back.pressed.connect(self._on_back_pressed)
	$Next.pressed.connect(self._on_next_pressed)
	if global.order != []:
		$orderIcon.visible = true
	#get_liquid_inside_cup_animation(anim)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(liquid_station_global.liquid_layer)
	pass

func _on_back_pressed():
	$button.play()
	get_tree().change_scene_to_file("res://scenes/Toppings/Toppings.tscn")

func _on_next_pressed():
	$button.play()
	get_tree().change_scene_to_file("res://scenes/FinalStation/FinalStation.tscn")


func _on_texture_button_pressed() -> void:
	$button.play()
	$order.visible = true
	$close.visible = true
	$order/Label.visible = true
	$order/Label.set_text(global.orderPaper)
	

func _on_close_pressed() -> void:
	$button.play()
	$order.visible = false
	$order/Label.visible = false
	$close.visible = false


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
