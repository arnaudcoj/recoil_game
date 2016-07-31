
extends Node

var levels = []
var index = 0

func _ready():
	load_levels_from_folder()
	
func load_levels_from_folder():
	var path = "res://scenes/levels"
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while(file_name != ""):
		if dir.current_is_dir():
			pass
		else:
			levels.append(load(path + "/" + file_name))
		file_name = dir.get_next()

func next_level():
	index = min(levels.size() -1, index + 1)
	
func previous_level():
	index = max(0, index - 1)
	
func get_current_level():
	return levels[index]