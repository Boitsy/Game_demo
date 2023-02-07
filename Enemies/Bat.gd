extends KinematicBody2D

onready var stats = $Stats
var knockback: = Vector2.ZERO

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)


func _on_Hurtbox_area_entered(area):
	knockback = area.knockback_vector * 100
	#Knock off one health from health if the bat gets hit.
	stats.health -= area.damage
	


#Get the signal from "Stats" script
func _on_Stats_no_health():
	queue_free()
