extends Node2D

@onready var anim = $Polygon2D/liquid_animations
var layer = 0
var wait_for_next_layer = false

# Initialize these to handle different liquids and combinations
var has_tea_been_poured = false
var has_coffee_been_poured = false
var has_smoothie_been_poured = false
var has_cow_milk_been_poured = false
var has_oat_milk_been_poured = false
var has_almond_milk_been_poured = false

func _ready() -> void:
	anim.hide()

func _process(delta: float) -> void:
	manage_animations()
	allow_next_layer()

func manage_animations():
	# Handle the first pour of liquid
	if layer == 0 and not wait_for_next_layer:
		if liquid_station_global.tea_pouring and not anim.is_playing():
			anim.show()
			anim.play("tea-1")
			layer += 1
			liquid_station_global.tea = 1
			has_tea_been_poured = true
			wait_for_next_layer = true  # Prevent immediate transition to the next layer
			return  # Exit the function to ensure no further actions are taken this frame

		if liquid_station_global.coffee_pouring and not anim.is_playing():
			anim.show()
			anim.play("coffee-1")
			layer += 1
			liquid_station_global.coffee = 1
			has_coffee_been_poured = true
			wait_for_next_layer = true  # Prevent immediate transition to the next layer
			return  # Exit the function to ensure no further actions are taken this frame

		elif liquid_station_global.smoothie_pouring and not anim.is_playing():
			anim.show()
			anim.play("smoothie-1")
			layer += 1
			liquid_station_global.smoothie = 1
			has_smoothie_been_poured = true
			wait_for_next_layer = true  # Prevent immediate transition to the next layer
			return  # Exit the function to ensure no further actions are taken this frame

		elif liquid_station_global.cow_milk_pouring and not anim.is_playing():
			anim.show()
			anim.play("cow-milk-1")
			layer += 1
			liquid_station_global.cow_milk = 1
			has_cow_milk_been_poured = true
			wait_for_next_layer = true  # Prevent immediate transition to the next layer
			return  # Exit the function to ensure no further actions are taken this frame

		elif liquid_station_global.oat_milk_pouring and not anim.is_playing():
			anim.show()
			anim.play("oat-milk-1")
			layer += 1
			liquid_station_global.oat_milk = 1
			has_oat_milk_been_poured = true
			wait_for_next_layer = true  # Prevent immediate transition to the next layer
			return  # Exit the function to ensure no further actions are taken this frame

		elif liquid_station_global.almond_milk_pouring and not anim.is_playing():
			anim.show()
			anim.play("almond-milk-1")
			layer += 1
			liquid_station_global.almond_milk = 1
			has_almond_milk_been_poured = true
			wait_for_next_layer = true  # Prevent immediate transition to the next layer
			return  # Exit the function to ensure no further actions are taken this frame

	# Handle the second layer, possibly after a delay or external trigger
	elif layer == 1 and not wait_for_next_layer:
		
		######### COW MILK AND TEA ##########
		if has_tea_been_poured and liquid_station_global.cow_milk_pouring and not anim.is_playing():
			anim.play("tea-cow-milk-2")
			layer += 1
			has_cow_milk_been_poured = true
			liquid_station_global.cow_milk = 1
			liquid_station_global.tea = 1
			return  # Again, ensure no further actions are taken this frame
			
		elif has_cow_milk_been_poured and liquid_station_global.tea_pouring and not anim.is_playing():
			anim.play("cow-milk-tea-2")
			layer += 1
			has_tea_been_poured = true
			liquid_station_global.cow_milk = 1
			liquid_station_global.tea = 1
			return
			
		######### COW MIlK AND COFFEE #########
		if has_coffee_been_poured and liquid_station_global.cow_milk_pouring and not anim.is_playing():
			anim.play("coffee-cow-milk-2")
			layer += 1
			has_cow_milk_been_poured = true
			liquid_station_global.cow_milk = 1
			liquid_station_global.coffee = 1
			return  # Again, ensure no further actions are taken this frame
			
		elif has_cow_milk_been_poured and liquid_station_global.coffee_pouring and not anim.is_playing():
			anim.play("cow-milk-coffee-2")
			layer += 1
			has_coffee_been_poured = true
			liquid_station_global.cow_milk = 1
			liquid_station_global.coffee = 1
			return
		
		######### COW MIlK AND SMOOTHIE #########
		if has_smoothie_been_poured and liquid_station_global.cow_milk_pouring and not anim.is_playing():
			anim.play("smoothie-cow-milk-2")
			layer += 1
			has_cow_milk_been_poured = true
			liquid_station_global.cow_milk = 1
			liquid_station_global.smoothie = 1
			return 
			
		elif has_cow_milk_been_poured and liquid_station_global.smoothie_pouring and not anim.is_playing():
			anim.play("cow-milk-smoothie-2")
			layer += 1
			has_smoothie_been_poured = true
			liquid_station_global.cow_milk = 1
			liquid_station_global.smoothie = 1
			return
			
		######### OAT MIlK AND TEA #########
		if has_tea_been_poured and liquid_station_global.oat_milk_pouring and not anim.is_playing():
			anim.play("tea-oat-milk-2")
			layer += 1
			has_oat_milk_been_poured = true
			liquid_station_global.oat_milk = 1
			liquid_station_global.tea = 1
			return
			
		elif has_oat_milk_been_poured and liquid_station_global.tea_pouring and not anim.is_playing():
			anim.play("oat-milk-tea-2")
			layer += 1
			has_tea_been_poured = true
			liquid_station_global.oat_milk = 1
			liquid_station_global.tea = 1
			return
			
		######### OAT MIlK AND COFFEE #########
		if has_coffee_been_poured and liquid_station_global.oat_milk_pouring and not anim.is_playing():
			anim.play("coffee-oat-milk-2")
			layer += 1
			has_oat_milk_been_poured = true
			liquid_station_global.oat_milk = 1
			liquid_station_global.coffee = 1
			return
			
		elif has_oat_milk_been_poured and liquid_station_global.coffee_pouring and not anim.is_playing():
			anim.play("oat-milk-coffee-2")
			layer += 1
			has_coffee_been_poured = true
			liquid_station_global.oat_milk = 1
			liquid_station_global.coffee = 1
			return
			
		######### OAT MIlK AND SMOOTHIE #########
		if has_smoothie_been_poured and liquid_station_global.oat_milk_pouring and not anim.is_playing():
			anim.play("smoothie-oat-milk-2")
			layer += 1
			has_oat_milk_been_poured = true
			liquid_station_global.oat_milk = 1
			liquid_station_global.smoothie = 1
			return
			
		elif has_oat_milk_been_poured and liquid_station_global.smoothie_pouring and not anim.is_playing():
			anim.play("oat-milk-smoothie-2")
			layer += 1
			has_smoothie_been_poured = true
			liquid_station_global.oat_milk = 1
			liquid_station_global.smoothie = 1
			return
			
		######### ALMOND MIlK AND TEA #########
		if has_tea_been_poured and liquid_station_global.almond_milk_pouring and not anim.is_playing():
			anim.play("tea-almond-milk-2")
			layer += 1
			has_almond_milk_been_poured = true
			liquid_station_global.almond_milk = 1
			liquid_station_global.tea = 1
			return
			
		elif has_almond_milk_been_poured and liquid_station_global.tea_pouring and not anim.is_playing():
			anim.play("almond-milk-tea-2")
			layer += 1
			has_tea_been_poured = true
			liquid_station_global.almond_milk = 1
			liquid_station_global.tea = 1
			return
			
		######### ALMOND MIlK AND COFFEE #########
		elif has_coffee_been_poured and liquid_station_global.almond_milk_pouring and not anim.is_playing():
			anim.play("coffee-almond-milk-2")
			layer += 1
			has_almond_milk_been_poured = true
			liquid_station_global.almond_milk = 1
			liquid_station_global.coffee = 1
			return
			
		elif has_almond_milk_been_poured and liquid_station_global.coffee_pouring and not anim.is_playing():
			anim.play("almond-milk-coffee-2")
			layer += 1
			has_coffee_been_poured = true
			liquid_station_global.almond_milk = 1
			liquid_station_global.coffee = 1
			return
			
		######### ALMOND MIlK AND SMOOTHIE #########
		if has_smoothie_been_poured and liquid_station_global.almond_milk_pouring and not anim.is_playing():
			anim.play("smoothie-almond-milk-2")
			layer += 1
			has_almond_milk_been_poured = true
			liquid_station_global.almond_milk = 1
			liquid_station_global.smoothie = 1
			return
			
		elif has_almond_milk_been_poured and liquid_station_global.smoothie_pouring and not anim.is_playing():
			anim.play("almond-milk-smoothie-2")
			layer += 1
			has_smoothie_been_poured = true
			liquid_station_global.almond_milk = 1
			liquid_station_global.smoothie = 1
			return

		######### TEA AND COFFEE #########
		if has_tea_been_poured and liquid_station_global.coffee_pouring and not anim.is_playing():
			anim.play("tea-coffee-2")
			layer += 1
			has_coffee_been_poured = true
			liquid_station_global.tea = 1
			liquid_station_global.coffee = 1
			return
			
		elif has_coffee_been_poured and liquid_station_global.tea_pouring and not anim.is_playing():
			anim.play("coffee-tea-2")
			layer += 1
			has_tea_been_poured = true
			liquid_station_global.tea = 1
			liquid_station_global.coffee = 1
			return
			
		######### COFFEE AND SMOOTHIE #########
		if has_coffee_been_poured and liquid_station_global.smoothie_pouring and not anim.is_playing():
			anim.play("coffee-smoothie-2")
			layer += 1
			has_smoothie_been_poured = true
			liquid_station_global.coffee = 1
			liquid_station_global.smoothie = 1
			return
		
		elif has_smoothie_been_poured and liquid_station_global.coffee_pouring and not anim.is_playing():
			anim.play("smoothie-coffee-2")
			layer += 1
			has_coffee_been_poured = true
			liquid_station_global.coffee = 1
			liquid_station_global.smoothie = 1
			return

		######### TEA AND SMOOTHIE #########
		if has_tea_been_poured and liquid_station_global.smoothie_pouring and not anim.is_playing():
			anim.play("tea-smoothie-2")
			layer += 1
			has_smoothie_been_poured = true
			liquid_station_global.tea = 1
			liquid_station_global.smoothie = 1
			return
		elif has_smoothie_been_poured and liquid_station_global.tea_pouring and not anim.is_playing():
			anim.play("smoothie-tea-2")
			layer += 1
			has_tea_been_poured = true
			liquid_station_global.tea = 1
			liquid_station_global.smoothie = 1
			return
		
		######### COW MILK AND OAT MILK #########
		if has_cow_milk_been_poured and liquid_station_global.oat_milk_pouring and not anim.is_playing():
			anim.play("cow-milk-oat-milk-2")
			layer += 1
			has_oat_milk_been_poured = true
			liquid_station_global.cow_milk = 1
			liquid_station_global.oat_milk = 1
			return
		
		if has_oat_milk_been_poured and liquid_station_global.cow_milk_pouring and not anim.is_playing():
			anim.play("oat-milk-milk-milk-2")
			layer += 1
			has_cow_milk_been_poured = true
			liquid_station_global.cow_milk = 1
			liquid_station_global.oat_milk = 1
			return
		
		######### OAT MILK AND ALMOND MILK #########
		
		######### COW MILK AND ALMOND MILK #########

		######### TEA AND TEA ##########
		if has_tea_been_poured and liquid_station_global.tea_pouring and not anim.is_playing():
			anim.play("tea-2")
			layer += 1
			liquid_station_global.tea = 2
			
		######### COFFEE AND COFFEE ##########
		elif has_coffee_been_poured and liquid_station_global.coffee_pouring and not anim.is_playing():
			anim.play("coffee-2")
			layer += 1
			liquid_station_global.coffee = 2
		
		######### SMOOTHIE AND SMOOTHIE ##########
		elif has_smoothie_been_poured and liquid_station_global.smoothie_pouring and not anim.is_playing():
			anim.play("smoothie-2")
			layer += 1
			liquid_station_global.smoothie = 2

		######### COW MILK AND COW MILK ##########
		elif has_cow_milk_been_poured and liquid_station_global.cow_milk_pouring and not anim.is_playing():
			anim.play("cow-milk-2")
			layer += 1
			liquid_station_global.cow_milk = 2

		######### OAT MILK AND OAT MILK ##########
		elif has_oat_milk_been_poured and liquid_station_global.oat_milk_pouring and not anim.is_playing():
			anim.play("oat-milk-2")
			layer += 1
			liquid_station_global.oat_milk = 2

		######### ALMOND MILK AND ALMOND MILK ##########
		elif has_almond_milk_been_poured and liquid_station_global.almond_milk_pouring and not anim.is_playing():
			anim.play("almond-milk-2")
			layer += 1
			liquid_station_global.almond_milk = 2


func allow_next_layer():
	wait_for_next_layer = false  # Reset this flag to allow progression to the next layer

func reset_animation():
	anim.stop()
	anim.hide()
	layer = 0
	has_tea_been_poured = false
	has_coffee_been_poured = false
	has_cow_milk_been_poured = false
	wait_for_next_layer = false  # Ensure that layer transitions can happen after reset
