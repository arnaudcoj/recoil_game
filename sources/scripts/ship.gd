
extends RigidBody2D

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
		fire_canon_up()
	if event.is_action_pressed("ui_down"):
		fire_canon_down()
	if event.is_action_pressed("ui_left"):
		fire_canon_left()
	if event.is_action_pressed("ui_right"):
		fire_canon_right()


func fire_canon_up():
	var impulse = - (canon_up.get_global_pos() - get_global_pos())
	apply_impulse(Vector2(0,0), impulse)
	
func fire_canon_down():
	var impulse = - (canon_down.get_global_pos() - get_global_pos())
	apply_impulse(Vector2(0,0), impulse)

func fire_canon_left():
	var impulse = - (canon_left.get_global_pos() - get_global_pos())
	apply_impulse(Vector2(0,0), impulse)
	
func fire_canon_right():
	var impulse = - (canon_right.get_global_pos() - get_global_pos())
	apply_impulse(Vector2(0,0), impulse)