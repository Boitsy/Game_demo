extends KinematicBody2D


var velocity: = Vector2.ZERO
export var maxspeed: = 80
const acceleration: = 500
const friction: =  500

enum{
	Move,
	Roll,
	Attack
}
var state = Move

#Won't initialize until the AnimationPlayer node is ready.
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
#The parameters/playback can be found by hovering over playback on AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	#When the game is ready activate AnimationTree.
	animation_tree.active = true

func _physics_process(delta):
	match state:
		Move:
			move_state(delta)
		
		Roll:
			pass
		
		Attack:
			attack_state(delta)
	

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	#Vectors get normalized so that the character doesn't go faster when moving diagonally.
	input_vector = input_vector.normalized()
 
	if input_vector != Vector2.ZERO:
		#The parameters used in the "set" function can be found by hovering over "Run" and "Idle" respectively.
		#These functions set the animation blend positions to our input_vector.
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_tree.set("parameters/Attack/blend_position", input_vector)
		
		#Use the "Run" animations.
		animation_state.travel("Run")
		
		#Get closer to maxspeed by adding acceleration every frame. Delta binds it to irl time instead of fps.
		#this prevents the game slowing down because of lag etc.
		velocity = velocity.move_toward(input_vector * maxspeed, acceleration * delta)
		
	else:
		#Use the "Idle" animations.
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	#The character stops completely if it hits a wall it can't slide across.
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("attack"):
		state = Attack
	
	
func attack_state(delta):
	velocity = Vector2.ZERO
	animation_state.travel("Attack")

func attack_state_finished():
	state = Move
