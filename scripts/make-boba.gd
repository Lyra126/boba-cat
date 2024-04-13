extends Node2D

var cupsize : String = ""
var small : Texture = preload("res://assets/small.png")
var medium : Texture = preload("res://assets/med.png")
var large : Texture = preload("res://assets/large.png")
var smallTea : Texture = preload("res://assets/smallTea.png")
var medTea : Texture = preload("res://assets/medTea.png")
var largeTea : Texture = preload("res://assets/largeTea.png")
var smallCoffee : Texture = preload("res://assets/smallCoffee.png")
var medCoffee : Texture = preload("res://assets/medCoffee.png")
var largeCoffee : Texture = preload("res://assets/largeCoffee.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	$Back.pressed.connect(self._on_back_pressed)
	$Next.pressed.connect(self._on_next_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/customer_line.tscn")


func _on_next_pressed():
	print("no next scene yet")

func _on_largecup_pressed():
	$cupsize/cup.set_texture(large)
	cupsize = "l"

func _on_medcup_pressed():
	$cupsize/cup.set_texture(medium)
	cupsize = "m"

func _on_smallcup_pressed():
	$cupsize/cup.set_texture(small)
	cupsize = "s"

func _on_tea_pressed():
	if ($cupsize/cup.get_texture() != null && cupsize != null):
		if(cupsize == "s"):
			$cupsize/cup.set_texture(smallTea)
		elif(cupsize == "m"):
			$cupsize/cup.set_texture(medTea)
		elif(cupsize == "l"):
			$cupsize/cup.set_texture(largeTea)

func _on_coffee_pressed():
	if ($cupsize/cup.get_texture() != null && cupsize != null):
		if(cupsize == "s"):
			$cupsize/cup.set_texture(smallCoffee)
		elif(cupsize == "m"):
			$cupsize/cup.set_texture(medCoffee)
		elif(cupsize == "l"):
			$cupsize/cup.set_texture(largeCoffee)
