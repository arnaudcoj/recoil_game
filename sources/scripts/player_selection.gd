
extends Panel

signal start
onready var container = get_node("container")
onready var player1 = container.get_node("player1")
onready var player2 = container.get_node("player2")
onready var player3 = container.get_node("player3")
onready var player4 = container.get_node("player4")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_start_pressed():
	emit_signal("start", [player1.is_pressed(), player2.is_pressed(), player3.is_pressed(), player4.is_pressed()])
	hide()

