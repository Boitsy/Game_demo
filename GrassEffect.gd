extends Node2D
onready var animated_sprite = $AnimatedSprite

func _ready():
	#Plays the animaton when the Node and it's children have entered the scene.
	animated_sprite.play("animate")

func _on_AnimatedSprite_animation_finished():
	#When it is finished the GrassEffect instances are deleted.
	queue_free()
