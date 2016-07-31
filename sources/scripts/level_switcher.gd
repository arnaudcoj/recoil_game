
extends Node

var skins = []
var index = 0

func _ready():
	load_skins_from_folder()
	
func load_skins_from_folder():
	var path = "res://scenes/levels"
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while(file_name != ""):
		if dir.current_is_dir():
			pass
		else:
			skins.append(load(path + "/" + file_name))
		file_name = dir.get_next()

func next_skin():
	index = min(skins.size() -1, index + 1)
	
func previous_skin():
	index = max(0, index - 1)
	
func get_current_skin():
	return skins[index]