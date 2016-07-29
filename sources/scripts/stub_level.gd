
extends StaticBody2D

onready var bullets = get_node("bullets")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func add_bullet(bullet):
	bullets.add_child(bullet)

func clear_bullets():
	for child in bullets.get_children():
		child.queue_free()
