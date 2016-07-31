
extends Node

var main

func _ready():
	main = get_tree().get_root().get_node("main")

func get_main():
	return main

func get_game():
	return main.get_node("game")
	
func get_level():
	return main.get_node("game").level
	
func get_players():
	return main.get_node("game/players")