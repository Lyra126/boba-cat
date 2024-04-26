extends Node

var SomethingBeingClickedRn = false
var prevOrderFinished = false
var currOrderFinished = false
var currCustomer = "cat1"
var allCustomers = ["cat1", "cat2", "cat3", "cat4", "cat5", "cat6", "cat7", "cat8", "cat9", "cat10"]
var visitedCustomers = []
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
var dialogueCompleted = false
var order = []
var playerOrder = []
var totalCurrency = 0
var toppings_inserted = []
var liquids_poured = []
var syrups_poured = []
var desserts_picked = []
var hasCup = false

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

#func reset_liquid_inside_cup(sprite):
	#sprite.delete_texture() 
