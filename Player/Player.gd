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
	input_vector = input_vector.normalized()
 
	if input_vector != Vector2.ZERO:
		
		#Get closer to maxspeed by adding acceleration every frame
		velocity = velocity.move_toward(input_vector * maxspeed, acceleration * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	#Remembers the velocity after the collision
	velocity = move_and_slide(velocity)
	print(velocity)
