
extends Panel

signal start

onready var level_switcher = get_node("level_switcher")
onready var level = get_node("level")

var l1 = preload("res://scenes/levels/first_level.tscn")
var l2 = preload("res://scenes/levels/second_level.tscn")

func _ready():
	set_process_input(true)
	change_level(level_switcher.get_current_level().instance())

func _input(event):
	if event.is_action_pressed("p1_right"):
		next_level()
	elif event.is_action_pressed("p1_left"):
		previous_level()
	elif event.is_action_pressed("p1_start"):
		start()

func start():
	emit_signal("start", get_level())

func _on_player_start():
	start()

func next_level():
	level_switcher.next_level()
	change_level(level_switcher.get_current_level().instance())

func previous_level():
	level_switcher.previous_level()
	change_level(level_switcher.get_current_level().instance())

func change_level(new_level):
	var level_pos = level.get_pos()
	level.queue_free()
	level = new_level
	level.set_pos(level_pos)
	level.scale(Vector2(0.5,0.5))
	add_child(level)
	
func get_level():
	var res = level.duplicate()
	res.scale(Vector2(2,2))
	return res