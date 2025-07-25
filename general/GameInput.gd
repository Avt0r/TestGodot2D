class_name GameInput
extends Node

signal move(int)
signal jump
signal attack
signal esc

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_left"): move.emit(-1)
	elif Input.is_action_pressed("ui_right"): move.emit(1)
	else: move.emit(0)
	
	if Input.is_action_pressed("jump"): jump.emit()
	if Input.is_action_pressed("attack"): attack.emit()
	if Input.is_action_just_pressed("esc"): esc.emit()
