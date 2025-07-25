class_name UI
extends CanvasLayer

@onready var main_menu:Control = $Main
@onready var game_menu:Control = $Game

@onready var hud:HUD = $Game/HUD
@onready var game_over:Control = $Game/GameOver
@onready var pause:Control = $Game/Pause

func _ready() -> void:
	on_menu()

func on_menu() -> void:
	main_menu.show()
	game_menu.hide()

func on_game() -> void:
	main_menu.hide()
	game_menu.show()
	
	hud.show()
	game_over.hide()
	pause.hide()

func on_game_over() -> void:
	pause.hide()
	game_over.show()

func on_pause() -> void:
	if game_over.visible: return
	
	if pause.visible:
		pause.hide()
	else:
		pause.show()
