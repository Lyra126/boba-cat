extends Node 


func _ready():
	pass

var SomethingBeingClickedRn = false
var timeOver = false
var timerInProgress = false
var time: float = 0.0
var mins: int  = 0
var secs: int = 0
var orderPaper : String
var allCustomers = ["cat1", "cat2", "cat3", "cat4", "cat5", "cat6", "cat7", "cat8", "cat9", "cat10"]
var randomIndex = randi() % allCustomers.size()
var currCustomer = allCustomers[randomIndex]
var nextCustomerCalled = false
var cat1 = preload("res://assets/cats/cat1.png")
var cat2 = preload("res://assets/cats/cat2.png")
var cat3 = preload("res://assets/cats/cat3.png")
var cat4 = preload("res://assets/cats/cat4.png")
var cat5 = preload("res://assets/cats/cat5.png")
var cat6 = preload("res://assets/cats/cat6.png")
var cat7 = preload("res://assets/cats/cat7.png")
var cat8 = preload("res://assets/cats/cat8.png")
var cat9 = preload("res://assets/cats/cat9.png")
var cat10 = preload("res://assets/cats/cat10.png")

var bobaBalls = preload("res://assets/toppings_station/assets/toppings-in-cup/boba-pearls.png")
var dalgonaChunks = preload("res://assets/toppings_station/assets/toppings-in-cup/dalgona-chunks.png")
var fruitJelly = preload("res://assets/toppings_station/assets/toppings-in-cup/fruit-jelly.png")
var poppingBoba = preload("res://assets/toppings_station/assets/toppings-in-cup/popping-boba.png")
var strawberrySlices = preload("res://assets/toppings_station/assets/toppings-in-cup/strawberry-slices.png")

var dialogueCompleted = false
var order = []
var playerOrder = []
var orderCompleted = false
var orderShown = false
var totalCurrency = 0
var toppings_inserted = []
var liquids_poured = []
var syrups_poured = []
var desserts_picked = []
var hasCup = false
var hasLid = false
var topping_sprites = []
var cookies_added = []
var cookies_sprites = []
var trash_clicked
var topping_sprite
var toppings_sprites
var cookie_sprite
var cookie_sprites_locations
var hasStraw
var straw_sprite

var shownCustomerTutorial = false
var shownToppingsTutorial = false
var shownLiquidsTutorial = false
var shownFinalStation = false


func _process(delta):
	if timerInProgress:
		time += delta
		secs = fmod(time, 60)
		mins = fmod(time, 3600) / 60
		if(mins == 1 && secs == 30):
			timeOver = true
			timerInProgress = false
			print("TIME OVER")
			
	
	
func get_customer_texture(customer):
	match customer:
		"cat1":
			return cat1
		"cat2":
			return cat2
		"cat3":
			return cat3
		"cat4":
			return cat4
		"cat5":
			return cat5
		"cat6":
			return cat6
		"cat7":
			return cat7
		"cat8":
			return cat8
		"cat9":
			return cat9
		"cat10":
			return cat10
	return null
	
func get_liquid_inside_cup(sprite):
	if liquid_station_global.liquid_layer == 1:
		if liquid_station_global.tea == 1:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-1.png"))
		elif liquid_station_global.coffee == 1:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-1.png"))
		elif liquid_station_global.smoothie == 1:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-1.png"))
		elif liquid_station_global.cow_milk == 1:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-1.png"))
		elif liquid_station_global.almond_milk == 1:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-1.png"))
		elif liquid_station_global.oat_milk == 1:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-1.png"))
			
	elif liquid_station_global.liquid_layer == 2:
		
	######### TEA AND COW MILK ##########
		if liquid_station_global.tea == 1 and liquid_station_global.cow_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-cow-milk-2.png"))
		if liquid_station_global.cow_milk == 1 and liquid_station_global.tea == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-tea-2.png"))

	######### TEA AND ALMOND MILK ##########
		if liquid_station_global.tea == 1 and liquid_station_global.almond_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-almond-milk-2.png"))
		if liquid_station_global.almond_milk == 1 and liquid_station_global.tea == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-tea-2.png"))

	######### TEA AND OAT MILK ##########
		if liquid_station_global.tea == 1 and liquid_station_global.oat_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-oat-milk-2.png"))
		if liquid_station_global.oat_milk == 1 and liquid_station_global.tea == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-tea-2.png"))

	######### COFFEE AND COW MILK ##########
		if liquid_station_global.coffee == 1 and liquid_station_global.cow_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-cow-milk-2.png"))
		if liquid_station_global.cow_milk == 1 and liquid_station_global.coffee == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-coffee-2.png"))

	######### COFFEE AND ALMOND MILK ##########
		if liquid_station_global.coffee == 1 and liquid_station_global.almond_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-almond-milk-2.png"))
		if liquid_station_global.almond_milk == 1 and liquid_station_global.coffee == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-coffee-2.png"))

	######### COFFEE AND OAT MILK ##########
		if liquid_station_global.coffee == 1 and liquid_station_global.oat_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-oat-milk-2.png"))
		if liquid_station_global.oat_milk == 1 and liquid_station_global.coffee == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-coffee-2.png"))

	######### SMOOTHIE AND COW MILK ##########
		if liquid_station_global.smoothie == 1 and liquid_station_global.cow_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-cow-milk-2.png"))
		if liquid_station_global.cow_milk == 1 and liquid_station_global.smoothie == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-smoothie-2.png"))

	######### SMOOTHIE AND ALMOND MILK ##########
		if liquid_station_global.smoothie == 1 and liquid_station_global.almond_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-almond-milk-2.png"))
		if liquid_station_global.almond_milk == 1 and liquid_station_global.smoothie == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-smoothie-2.png"))

	######### SMOOTHIE AND OAT MILK ##########
		if liquid_station_global.smoothie == 1 and liquid_station_global.oat_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-oat-milk-2.png"))
		if liquid_station_global.oat_milk == 1 and liquid_station_global.smoothie == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-smoothie-2.png"))

	######### TEA AND COFFEE ##########
		if liquid_station_global.tea == 1 and liquid_station_global.coffee == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-coffee-2.png"))
		if liquid_station_global.coffee == 1 and liquid_station_global.tea == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-tea-2.png"))

	######### TEA AND SMOOTHIE ##########
		if liquid_station_global.tea == 1 and liquid_station_global.smoothie == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-smoothie-2.png"))
		if liquid_station_global.smoothie == 1 and liquid_station_global.tea == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-tea-2.png"))

	######### COFFEE AND SMOOTHIE ##########
		if liquid_station_global.coffee == 1 and liquid_station_global.smoothie == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-smoothie-2.png"))
		if liquid_station_global.smoothie == 1 and liquid_station_global.coffee == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-coffee-2.png"))

	######### COW MILK AND ALMOND MILK ##########
		if liquid_station_global.cow_milk == 1 and liquid_station_global.almond_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-almond-milk-2.png"))
		if liquid_station_global.almond_milk == 1 and liquid_station_global.cow_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-cow-milk-2.png"))

	######### OAT MILK AND COW MILK ##########
		if liquid_station_global.oat_milk == 1 and liquid_station_global.cow_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-cow-milk-2.png"))
		if liquid_station_global.cow_milk == 1 and liquid_station_global.oat_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-oat-milk-2.png"))

	######### ALMOND MILK AND OAT MILK ##########
		if liquid_station_global.almond_milk == 1 and liquid_station_global.oat_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-oat-milk-2.png"))
		if liquid_station_global.oat_milk == 1 and liquid_station_global.almond_milk == 2:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-almond-milk-2.png"))

		######### TEA AND TEA ##########
		if liquid_station_global.tea == 3:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/tea-2.png"))
			
		######### COFFEE AND COFFEE ##########
		if liquid_station_global.coffee == 3:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/coffee-2.png"))
			
		######### SMOOTHIE AND SMOOTHIE ##########
		if liquid_station_global.smoothie == 3:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/smoothie-2.png"))
			
		######### COW MILK AND COW MILK ##########
		if liquid_station_global.cow_milk == 3:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/cow-milk-2.png"))
			
		######### ALMOND MILK AND ALMOND MILK ##########
		if liquid_station_global.almond_milk == 3:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/almond-milk-2.png"))
			
		######### OAT AND OAT ##########
		if liquid_station_global.oat_milk == 3:
			sprite.set_texture(load("res://assets/liquid_station/assets/cup-liquids/oat-milk-2.png"))

func get_toppings_inside_cup(t1, t2, t3, t4, t5):
	toppings_sprites = [t1, t2, t3, t4, t5]
	for i in range(toppings_sprites.size()):
		topping_sprite = toppings_sprites[i]
		if topping_sprite and i < toppings_inserted.size() and toppings_inserted[i]:
			topping_sprite.set_texture(load(topping_sprites[i]))
			print(topping_sprites[i])
		
func get_cookies(c1,c2,c3,c4,c5):
	cookie_sprites_locations = [c1, c2, c3, c4, c5]
	for i in range(cookie_sprites_locations.size()):
		cookie_sprite = cookie_sprites_locations[i]
		if cookie_sprite and i < cookies_added.size() and cookies_added[i]:
			cookie_sprite.set_texture(load(cookies_sprites[i]))
			print(cookies_sprites[i])
			
func reset_drink():
	playerOrder.resize(0)
	toppings_inserted.resize(0)
	liquids_poured.resize(0)
	liquid_station_global.liquid_layer = 0
	syrups_poured.resize(0)
	toppings_station_global.toppings_layers = 0
	topping_sprite.texture = null
	topping_sprites.resize(0)
	cookies_sprites.resize(0)
	hasLid = false
	cookies_added.resize(0)
	final_station_global.cookie_layers = 0
	hasStraw = false
	straw_sprite = null
	#toppings_sprites.texture = null
