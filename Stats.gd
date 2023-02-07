extends Node

signal no_health
export(int) var max_health = 1

#Only used setter getter's set part then uses the set_health function to set the health and emit the signal
#The onready for this variable is neccessary as it won't register the export variable that is set
#but use what has been set above (1).
onready var health = max_health setget set_health


func set_health(value):
	#Simple health caculator
	health = value
	if health <= 0:
		emit_signal("no_health")
