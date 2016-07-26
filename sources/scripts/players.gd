
extends Node2D

var nb_players = 2
signal player_died

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_ship_died():
	print(get_child_count())
	nb_players -= 1
	emit_signal("player_died")


func _on_ship1_died():
	print(get_child_count())
	nb_players -= 1
	emit_signal("player_died")
