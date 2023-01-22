extends Node2D

func create_grass_effect():
	
	#This is the scene of the effect which shows grass breaking.
	var GrassEffect = load ("res://GrassEffect.tscn")
	#This is the instances of grass effect.
	var grass_effect = GrassEffect.instance()
		
	#Adds the GrassEffect as an child of the "world" node.
	var world = get_tree().current_scene
	world.add_child(grass_effect)
		
	#This gets the global position of the effect and equals it to the global position of the "Grass".
	grass_effect.global_position = global_position




func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	#When it is finished the Grass instances are deleted.
	queue_free()

