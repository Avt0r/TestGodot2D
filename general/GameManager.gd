class_name GameManager
extends Node

static var instance:GameManager
static var game_input:GameInput 
static var ui:UI
static var level_manager:LevelManager

func _ready() -> void:
	instance = self
	game_input = $GameInput
	ui = $UI
	level_manager = $LevelManager
	
	game_input.esc.connect(ui.on_pause)

func play():
	ui.on_game()
	
	level_manager.play()

func game_over():
	ui.on_game_over()

func restart():
	level_manager.restart()
	ui.hud.restart()
