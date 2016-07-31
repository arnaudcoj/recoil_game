
extends Node2D

signal start

export var player_idx = 0

var selected = false

onready var skin = get_node("skin")

func _ready():
	set_selected(false)
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("p" + str(player_idx) + "_up"):
		set_selected(true)
	elif event.is_action_pressed("p" + str(player_idx) + "_down"):
		set_selected(false)
	elif event.is_action_pressed("p" + str(player_idx) + "_start"):
		if selected : emit_signal("start")

func set_selected(boolean):
	selected = boolean
	skin.set_hidden(!boolean)