class_name HUD
extends Control

static var instance:HUD

var kills_val := 0

signal hp_upd(int)
signal kills_upd

func _ready() -> void:
	instance = self
	hp_upd.connect(func(val): $Info/HP.text = "HP: " + str(val))
	kills_upd.connect(func(): 
		kills_val += 1
		$Info/Kills.text = "Kills: " + str(kills_val))

func restart() -> void:
	kills_val = 0
	$Info/Kills.text = "Kills: " + str(kills_val)
