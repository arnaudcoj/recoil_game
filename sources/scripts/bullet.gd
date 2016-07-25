
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	pass

func _on_Timer_timeout():
	queue_free()
