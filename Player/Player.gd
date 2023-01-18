extends KinematicBody2D


var velocity: = Vector2.ZERO
export var maxspeed: = 80
const acceleration: = 500
const friction: =  500

#Won't initialize until the AnimationPlayer node is ready.
onready var animation_player = $AnimationPlayer


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	#Vectors get normalized so that the character doesn't go faster when moving diagonally.
	input_vector = input_vector.normalized()
 
	if input_vector != Vector2.ZERO:
		
		#Play the run_right animation when the input_vector is bigger than 0 or plays run_left animation 
		if input_vector.x > 0:
			animation_player.play("run_right")
		elif input_vector.x < 0:
			animation_player.play("run_left")
		elif input_vector.y > 0:
			animation_player.play("run_down")
		else:
			animation_player.play("run_up")
		#Get closer to maxspeed by adding acceleration every frame. Delta binds it to irl time instead of fps.
		#this prevents the game slowing down because of lag etc.
		velocity = velocity.move_toward(input_vector * maxspeed, acceleration * delta)
		
	else:
		animation_player.play("idle_right")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	#The character stops completely if it hits a wall it can't slide across.
	velocity = move_and_slide(velocity)
	
