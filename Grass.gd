extends Node2D


func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		
		#This is the scene
		var GrassEffect = load ("res://GrassEffect.tscn")
		#This is the instances
		var grass_effect = GrassEffect.instance()
		
		#Adds the GrassEffect as an child of the "world" node.
		var world = get_tree().current_scene
		world.add_child(grass_effect)
		
		#This gets the global position of the effect and equals it to the global position of the "Grass".
		grass_effect.global_position = global_position
		
		queue_free()



