class_name EnemyStateDestroy extends EnemyState

@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelarate_speed : float = 1.0

@export_category("AI")

var _damage_position : Vector2
var _direction : Vector2

## What happens when we initialize this state?
func init() -> void:
	enemy.enemy_destroyed.connect( _on_enemy_destroyed )
	pass

## What happens when the player enters theis State?
func enter() -> void:
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to( _damage_position )
	
	enemy.set_direction( _direction )
	enemy.velocity = _direction * -knockback_speed
	
	enemy.update_animation( anim_name )
	enemy.animation_player.animation_finished.connect( _on_animation_finished )
	disable_hurt_box()
	pass

## What happens when the player exits this State?
func exit() -> void:
	pass

## What happens constantly in this state?
func process( _delta : float) -> EnemyState:
	
	enemy.velocity -= enemy.velocity * decelarate_speed * _delta
	
	return null

## What happens when physics get updated in this state?
func physics (_delta : float) -> EnemyState:
	return null

func _on_enemy_destroyed( hurt_box : HurtBox ) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state( self )
	pass

func _on_animation_finished( _a : String ) -> void:
	enemy.queue_free()
	pass
	
func disable_hurt_box() -> void:
	var hurt_box : HurtBox = enemy.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false
