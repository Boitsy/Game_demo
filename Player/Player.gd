extends KinematicBody2D


var velocity: = Vector2.ZERO
export var maxspeed: = 80
const acceleration: = 500
const friction: =  500

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	#Vectors get normalized so that the character doesn't go faster when moving diagonally.
	input_vector = input_vector.normalized()
 
	if input_vector != Vector2.ZERO:
		
		#Get closer to maxspeed by adding acceleration every frame. Delta binds it to irl time instead of fps.
		#this prevents the game slowing down because of lag etc.
		velocity = velocity.move_toward(input_vector * maxspeed, acceleration * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	#The character stops completely if it hits a wall it can't slide across.
	velocity = move_and_slide(velocity)
	
