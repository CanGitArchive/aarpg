class_name State_Walk extends State

@export var move_speed : float = 100.0
@onready var idle: State = $"../Idle"
@onready var attack: State_Attack = $"../Attack"

## What happens when the player enters theis State?
func enter() -> void:
	player.update_animation("walk")
	pass

## What happens when the player exits this State?
func exit() -> void:
	pass
	
## What happens constantly in this state?
func process( _delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * move_speed
	
	if player.set_direction():
		player.update_animation("walk")
	
	return null

## What happens when physics get updated in this state?
func physics (_delta : float) -> State:
	return null
	
## What happens if we input events in this state?
func handle_input (_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
	
