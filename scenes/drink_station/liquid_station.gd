extends Node2D
@onready var openTrash = preload("res://assets/buttons/openTrash.png")
@onready var closeTrash = preload("res://assets/buttons/closeTrash.png")
@onready var anim = $"cup/liquid-in-cup/Polygon2D/liquid_animations_still"

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.hide()
	$Back.pressed.connect(self._on_back_pressed)
	$Next.pressed.connect(self._on_next_pressed)
	get_liquid_inside_cup_animation(anim)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/Toppings/Toppings.tscn")

func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/FinalStation/FinalStation.tscn")

func _on_area_2d_mouse_entered() -> void:
	$trash.texture = openTrash

func _on_area_2d_mouse_exited() -> void:
	$trash.texture = closeTrash

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.pressed:
				$trash.texture = closeTrash
				print("cup has been deleted")
				$cup.visible = false
				global.reset_drink()
				global.trash_clicked = true
				global.hasCup = false

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

func get_liquid_inside_cup_animation(anim):
	if liquid_station_global.liquid_layer == 1:
		anim.show()
		anim.modulate.a = 0.8
		if liquid_station_global.tea == 1:
			anim.play("tea-1")
			anim.pause()
		#elif liquid_station_global.coffee == 1:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-1.png"))
		#elif liquid_station_global.smoothie == 1:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-1.png"))
		#elif liquid_station_global.cow_milk == 1:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-1.png"))
		#elif liquid_station_global.almond_milk == 1:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-1.png"))
		#elif liquid_station_global.oat_milk == 1:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-1.png"))
			#
	#elif liquid_station_global.liquid_layer == 2:
		#
	########## TEA AND COW MILK ##########
		#if liquid_station_global.tea == 1 and liquid_station_global.cow_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-cow-milk-2.png"))
		#if liquid_station_global.cow_milk == 1 and liquid_station_global.tea == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-tea-2.png"))
#
	########## TEA AND ALMOND MILK ##########
		#if liquid_station_global.tea == 1 and liquid_station_global.almond_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-almond-milk-2.png"))
		#if liquid_station_global.almond_milk == 1 and liquid_station_global.tea == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-tea-2.png"))
#
	########## TEA AND OAT MILK ##########
		#if liquid_station_global.tea == 1 and liquid_station_global.oat_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-oat-milk-2.png"))
		#if liquid_station_global.oat_milk == 1 and liquid_station_global.tea == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-tea-2.png"))
#
	########## COFFEE AND COW MILK ##########
		#if liquid_station_global.coffee == 1 and liquid_station_global.cow_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-cow-milk-2.png"))
		#if liquid_station_global.cow_milk == 1 and liquid_station_global.coffee == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-coffee-2.png"))
#
	########## COFFEE AND ALMOND MILK ##########
		#if liquid_station_global.coffee == 1 and liquid_station_global.almond_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-almond-milk-2.png"))
		#if liquid_station_global.almond_milk == 1 and liquid_station_global.coffee == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-coffee-2.png"))
#
	########## COFFEE AND OAT MILK ##########
		#if liquid_station_global.coffee == 1 and liquid_station_global.oat_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-oat-milk-2.png"))
		#if liquid_station_global.oat_milk == 1 and liquid_station_global.coffee == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-coffee-2.png"))
#
	########## SMOOTHIE AND COW MILK ##########
		#if liquid_station_global.smoothie == 1 and liquid_station_global.cow_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-cow-milk-2.png"))
		#if liquid_station_global.cow_milk == 1 and liquid_station_global.smoothie == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-smoothie-2.png"))
#
	########## SMOOTHIE AND ALMOND MILK ##########
		#if liquid_station_global.smoothie == 1 and liquid_station_global.almond_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-almond-milk-2.png"))
		#if liquid_station_global.almond_milk == 1 and liquid_station_global.smoothie == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-smoothie-2.png"))
#
	########## SMOOTHIE AND OAT MILK ##########
		#if liquid_station_global.smoothie == 1 and liquid_station_global.oat_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-oat-milk-2.png"))
		#if liquid_station_global.oat_milk == 1 and liquid_station_global.smoothie == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-smoothie-2.png"))
#
	########## TEA AND COFFEE ##########
		#if liquid_station_global.tea == 1 and liquid_station_global.coffee == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-coffee-2.png"))
		#if liquid_station_global.coffee == 1 and liquid_station_global.tea == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-tea-2.png"))
#
	########## TEA AND SMOOTHIE ##########
		#if liquid_station_global.tea == 1 and liquid_station_global.smoothie == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-smoothie-2.png"))
		#if liquid_station_global.smoothie == 1 and liquid_station_global.tea == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-tea-2.png"))
#
	########## COFFEE AND SMOOTHIE ##########
		#if liquid_station_global.coffee == 1 and liquid_station_global.smoothie == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-smoothie-2.png"))
		#if liquid_station_global.smoothie == 1 and liquid_station_global.coffee == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-coffee-2.png"))
#
	########## COW MILK AND ALMOND MILK ##########
		#if liquid_station_global.cow_milk == 1 and liquid_station_global.almond_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-almond-milk-2.png"))
		#if liquid_station_global.almond_milk == 1 and liquid_station_global.cow_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-cow-milk-2.png"))
#
	########## OAT MILK AND COW MILK ##########
		#if liquid_station_global.oat_milk == 1 and liquid_station_global.cow_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-cow-milk-2.png"))
		#if liquid_station_global.cow_milk == 1 and liquid_station_global.oat_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-oat-milk-2.png"))
#
	########## ALMOND MILK AND OAT MILK ##########
		#if liquid_station_global.almond_milk == 1 and liquid_station_global.oat_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-oat-milk-2.png"))
		#if liquid_station_global.oat_milk == 1 and liquid_station_global.almond_milk == 2:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-almond-milk-2.png"))
#
		########## TEA AND TEA ##########
		#if liquid_station_global.tea == 3:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-2.png"))
			#
		########## COFFEE AND COFFEE ##########
		#if liquid_station_global.coffee == 3:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-2.png"))
			#
		########## SMOOTHIE AND SMOOTHIE ##########
		#if liquid_station_global.smoothie == 3:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-2.png"))
			#
		########## COW MILK AND COW MILK ##########
		#if liquid_station_global.cow_milk == 3:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-2.png"))
			#
		########## ALMOND MILK AND ALMOND MILK ##########
		#if liquid_station_global.almond_milk == 3:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-2.png"))
			#
		########## OAT AND OAT ##########
		#if liquid_station_global.oat_milk == 3:
			#sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-2.png"))

func _on_outside_order_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
