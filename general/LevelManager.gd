class_name LevelManager
extends Node

@export var player_res: Resource
@export var levels_res: Array[Resource]

@onready var camera: Camera2D = $GameCamera

func play():
	var level:Level = levels_res[0].instantiate()
	
	add_child(level)
	
	var player:Player = player_res.instantiate()
	
	level.add_child(player)
	
	player.position = level.player_spawn.position
	player.init()
	camera.target = player

func restart():
	for child in get_children():
		if child is Camera2D: continue
		child.free()
	
	GameManager.instance.play()
