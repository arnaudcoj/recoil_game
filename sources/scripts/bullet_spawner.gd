
extends Node

var bullet = preload("res://scenes/bullets/yellow_bullet.tscn")

func _ready():
	pass

func set_bullet_type(bullet_scn):
	bullet = bullet_scn

func get_bullet_instance():
	return bullet.instance()