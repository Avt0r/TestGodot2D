class_name Player
extends Unit

func init() -> void:
	HUD.instance.hp_upd.emit(hp)
	
	GameManager.game_input.move.connect(on_move)
	GameManager.game_input.jump.connect(on_jump)
	GameManager.game_input.attack.connect(on_attack)

func get_damage(attack:Attack):
	super.get_damage(attack)
	
	HUD.instance.hp_upd.emit(hp)

func die():
	GameManager.instance.game_over()
	super.die()
