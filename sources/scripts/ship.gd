
extends RigidBody2D
var bullet = preload("res://scenes/bullet.tscn")

onready var canons = get_node("canons")

onready var canon_up = canons.get_node("canon_up")
onready var canon_down = canons.get_node("canon_down")
onready var canon_left = canons.get_node("canon_left")
onready var canon_right = canons.get_node("canon_right")


func _ready():
	set_process_input(true)

func _input(event):
	if event.is_pressed() :
		print("input : ", get_global_pos())
	if event.is_action_pressed("ui_up"):
		fire_canon(canon_up)
	if event.is_action_pressed("ui_down"):
		fire_canon(canon_down)
	if event.is_action_pressed("ui_left"):
		fire_canon(canon_left)
	if event.is_action_pressed("ui_right"):
		fire_canon(canon_right)

func fire_canon(canon):
	var impulse = canon.get_global_pos() - get_global_pos()
	apply_impulse(Vector2(0,0), -impulse)
	var i_bullet = bullet.instance()
	get_tree().get_root().get_node("main").add_child(i_bullet)
	i_bullet.set_global_pos(canon.get_global_pos())
	i_bullet.set_rot(canon.get_rot() + get_rot())
	i_bullet.apply_impulse(Vector2(0,0), impulse * 10)