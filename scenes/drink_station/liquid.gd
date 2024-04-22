extends CPUParticles2D

@onready var timer = $Timer
var timer_started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emitting = false
	timer.wait_time = 0.65;
	timer.one_shot = true;
	#timer.autostart = false
	

func _process(delta: float) -> void:
	check_liquid_pouring()

func _on_timer_timeout() -> void:
	speed_scale = 0
	emitting = false
	
func check_timer_status() -> void:
	# This function updates the emitting status based on the timer's active status
	if timer.is_stopped() == false:
		emitting = true
	else:
		speed_scale = 0
		emitting = false

func check_liquid_pouring():
	if liquid_station_global.tea_pouring:
		timer.start()
		emitting = true
		check_timer_status()
		
	


