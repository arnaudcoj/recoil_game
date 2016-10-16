
extends Node2D

signal start_pressed

func _ready():
	set_process_input(true)
	print()
	print(exp(2))
	print(exp(3))
	print(exp(4))
	print(exp(5))

func _input(event):
	if event.is_action_pressed("p1_start") or event.is_action_pressed("p2_start") or event.is_action_pressed("p3_start") or event.is_action_pressed("p4_start"):
		emit_signal("start_pressed")