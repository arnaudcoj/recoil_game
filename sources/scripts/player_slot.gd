
extends Node2D

signal start

export var player_idx = 0

var selected = false

onready var skin = get_node("skin")

onready var skin_switcher = get_node("skin_switcher")

func _ready():
	set_selected(false)
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("p" + str(player_idx) + "_up"):
		set_selected(true)
	elif event.is_action_pressed("p" + str(player_idx) + "_down"):
		set_selected(false)
	elif selected && event.is_action_pressed("p" + str(player_idx) + "_right"):
		next_skin()
	elif selected && event.is_action_pressed("p" + str(player_idx) + "_left"):
		previous_skin()
	elif event.is_action_pressed("p" + str(player_idx) + "_start"):
		if selected : emit_signal("start")

func set_selected(boolean):
	selected = boolean
	skin.set_hidden(!boolean)
	
func next_skin():
	skin_switcher.next_skin()
	change_skin(skin_switcher.get_current_skin().instance())

func previous_skin():
	skin_switcher.previous_skin()
	change_skin(skin_switcher.get_current_skin().instance())

func change_skin(new_skin):
	var skin_pos = skin.get_pos()
	skin.queue_free()
	skin = new_skin
	skin.set_pos(skin_pos)
	add_child(skin)