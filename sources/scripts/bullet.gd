
extends RigidBody2D

var player

func _ready():
	pass

func _on_Timer_timeout():
	queue_free()
