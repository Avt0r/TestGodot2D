class_name Enemy
extends Unit

var target: Player

@export var move_direction:Vector2i
@export var collider:CollisionShape2D
@export var raycast:RayCast2D

var state:States = States.patrol

func _physics_process(delta: float) -> void:
	if is_dead(): return

	match state:
		States.patrol:
			if is_on_wall() or not raycast.is_colliding():
				move_direction.x *= -1
			
			on_move(move_direction.x)
		States.chase:
			move_direction.x = sign(target.position.x - self.position.x)
			
			if is_on_wall() or not raycast.is_colliding():
				on_move(0)
			else:
				on_move(move_direction.x)
		States.attack:
			on_move(0)
			on_attack()
	
	super._physics_process(delta)

func die():
	HUD.instance.kills_upd.emit()
	collider.free()
	super.die()

func _on_detect_area_body_entered(body: Node2D) -> void:
	if is_dead(): return
	if body is Player:
		state = States.chase
		target = body

func _on_detect_area_body_exited(body: Node2D) -> void:
	if is_dead(): return
	if body is Player:
		state = States.patrol
		target = null

func _on_damage_area_body_entered(body: Node2D) -> void:
	if is_dead(): return
	if body is Player:
		state = States.attack

func _on_damage_area_body_exited(body: Node2D) -> void:
	if is_dead(): return
	if body is Player:
		state = States.chase

enum States
{
	patrol,
	chase,
	attack
}
