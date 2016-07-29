
extends Panel

signal start
onready var container = get_node("container")
onready var player1 = container.get_node("player1")
onready var player2 = container.get_node("player2")
onready var player3 = container.get_node("player3")
onready var player4 = container.get_node("player4")
onready var start_button = container.get_node("start")

func _ready():
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("p1_up"):
		player1.set_pressed(true)
	elif event.is_action_pressed("p1_down"):
		player1.set_pressed(false)
		
	if event.is_action_pressed("p2_up"):
		player2.set_pressed(true)
	elif event.is_action_pressed("p2_down"):
		player2.set_pressed(false)
		
	if event.is_action_pressed("p3_up"):
		player3.set_pressed(true)
	elif event.is_action_pressed("p3_down"):
		player3.set_pressed(false)
		
	if event.is_action_pressed("p4_up"):
		player4.set_pressed(true)
	elif event.is_action_pressed("p4_down"):
		player4.set_pressed(false)
		
	if event.is_action_pressed("p1_start") or event.is_action_pressed("p2_start") or event.is_action_pressed("p3_start") or event.is_action_pressed("p4_start"):
		start()

func _on_start_pressed():
	start()

func start():
	emit_signal("start", [player1.is_pressed(), player2.is_pressed(), player3.is_pressed(), player4.is_pressed()])