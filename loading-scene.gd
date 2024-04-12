extends Control

const TARGET_SCENE_PATH:String = "res://customer_line.tscn"
const LOADING_DELAY:float = 1.0 # Adjust the delay time as needed
const PROGRESS_INCREMENT:float = 5 # Adjust the progress increment as needed

var loading_status : int
var progress : Array[float]
var loading_delay_timer: float = LOADING_DELAY
var progress_value: float = 0.0

@onready var progress_bar : ProgressBar = $ProgressBar

func _ready() -> void:
	# Start the asynchronous loading process
	ResourceLoader.load_threaded_request(TARGET_SCENE_PATH)

func _process(delta: float) -> void:
	if loading_delay_timer > 0:
		# Increment progress value gradually
		progress_value = clamp(progress_value + PROGRESS_INCREMENT * delta / LOADING_DELAY, 0.0, 1.0)
		progress_bar.value = progress_value * 100 # Change the ProgressBar value
		loading_delay_timer -= delta
		return

	# Update the status
	loading_status = ResourceLoader.load_threaded_get_status(TARGET_SCENE_PATH, progress)

	# Check the loading status
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = progress[0] * 100 # Change the ProgressBar value
		ResourceLoader.THREAD_LOAD_LOADED:
			# When done loading, change to the target scene
			var scene = ResourceLoader.load_threaded_get(TARGET_SCENE_PATH)
			if scene != null:
				get_tree().change_scene_to_packed(scene)
			else:
				print("Error: Loaded scene is null.")
		ResourceLoader.THREAD_LOAD_FAILED:
			# Well some error happened
			print("Error: Could not load resource:", TARGET_SCENE_PATH)
