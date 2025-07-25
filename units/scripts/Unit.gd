class_name Unit
extends CharacterBody2D

@export var hp:int = 1
@export var dmg:int = 1
@export var speed:float = 1
@export var jump_power:float = 1

@export var damage_area:Area2D
@export var anim:AnimationPlayer
@export var sprite:Sprite2D

func _physics_process(delta: float) -> void:
	if is_dead(): return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

func on_move(x:int):
	if is_dead(): return
	
	velocity.x = x * speed
	
	if x != 0: sprite.flip_h = false if x == 1 else true
	
	if x == 0:
		play_anim("idle")
	else:
		play_anim("move")

func on_jump():
	if is_dead(): return
	if not is_on_floor(): return
	
	velocity.y -= jump_power
	
	play_anim("jump")

func on_attack():
	if is_dead(): return
	
	play_anim("attack")

func deal_damage():
	for body in damage_area.get_overlapping_bodies():
		if body == self: continue
		
		if body.has_method("get_damage"):
			var attack = Attack.new()
			
			attack.damage_count = dmg
			
			body.get_damage(attack)

func get_damage(attack:Attack):
	if is_dead(): return
	
	hp -= attack.damage_count
	
	if hp <= 0:
		hp = 0
		die()
		return
	
	play_anim("hit")

func die():
	play_anim("die")

func play_anim(name:String):
	if anim.current_animation == "die": return
	
	match name:
		"die":
			anim.play("die")
		"move","idle","jump":
			if anim.is_playing() and (
				anim.current_animation == "attack" or
				anim.current_animation == "hit"): return
			
			anim.play(name)
		"attack":
			if anim.is_playing() and anim.current_animation == "hit": return
			
			anim.play("attack")
		"hit":
			anim.play("hit")

func is_dead() -> bool: return hp <= 0
