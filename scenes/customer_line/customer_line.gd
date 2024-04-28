extends Node2D

var OrderForm
@onready var progress_bar : TextureProgressBar = $Customer/TextureProgressBar
@onready var canfire = true
@onready var timer = $Customer/Timer
@onready var percentage_of_time
var nextCustomerCalled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Next.pressed.connect(self._on_next_pressed)
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	move_customer()
	get_tree().paused = false
	
func _input(event):
	if get_tree().paused:
		return

func move_customer():
	# Define the initial position and the target position
	var initial_position = $Customer.position
	var target_position = Vector2(-135, 0) 
	var distance = initial_position.distance_to(target_position)
	var speed = distance * 0.1
	$Customer.position = lerp(initial_position, target_position, min(1.0, speed * get_process_delta_time()))




func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/Toppings/Toppings.tscn")

	
	
func _process(delta):
	if global.dialogueCompleted:
		progress_bar.visible = true
		canfire = false
		timer.start()
		$OrderForm.visible = true
		$OrderForm.showOrder()
		global.dialogueCompleted = false
		
	if progress_bar.value == 100 and not nextCustomerCalled:
		timer.stop()
		nextCustomerCalled = true
		await get_tree().create_timer(2.0).timeout
		nextCustomer()
	elif timer.get_time_left() > 0:
		percentage_of_time = ((1 - timer.get_time_left() / timer.get_wait_time()) * 5000) #100
		progress_bar.value = percentage_of_time
			
		
func nextCustomer():
	$OrderForm.visible = false
	progress_bar.visible = false
	progress_bar.value = 0
	$OrderForm.generate_order()
	$OrderForm.showOrder()
	global.dialogueCompleted = false
	$Customer.visible = false;
	$Customer.position = Vector2(8040, 0)
	var randomIndex = randi() % global.allCustomers.size()
	global.currCustomer = global.allCustomers[randomIndex]
	$Customer.texture = global.get_customer_texture(global.currCustomer)
	$Customer.visible = true;
	await get_tree().create_timer(1.0).timeout
	move_customer()
	canfire = true
	nextCustomerCalled = false
