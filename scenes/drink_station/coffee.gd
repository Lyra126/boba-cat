extends Node2D

@onready var nozzle_anim = $"coffee nozzle/coffee nozzle down"
@onready var nozzle_still = $"coffee nozzle/coffee nozzle norm"

# Called when the node enters the scene tree for the first time.
func _ready():
	nozzle_still.show()
	nozzle_anim.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_nozzle_area_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("click") and liquid_station_global.coffee_set_to_pour:
		nozzle_anim.show()
		nozzle_anim.play()
		nozzle_still.hide()
		liquid_station_global.nozzle_anim_playing = true
		liquid_station_global.coffee_set_to_pour = false

func _on_nozzle_area_mouse_entered():
	print(liquid_station_global.coffee_set_to_pour)
	if liquid_station_global.coffee_set_to_pour:
		nozzle_still.scale = Vector2(0.58,0.58)

func _on_nozzle_area_mouse_exited():
	if liquid_station_global.coffee_set_to_pour:
		nozzle_still.scale = Vector2(0.495,0.495)

func _on_coffee_nozzle_down_animation_finished():
	nozzle_anim.stop()
	nozzle_anim.hide()
	nozzle_still.show()
	nozzle_still.scale = Vector2(0.495,0.495)
	liquid_station_global.nozzle_anim_playing = false
