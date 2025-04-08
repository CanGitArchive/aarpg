class_name State_Idle extends State
@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"


## What happens when the player enters theis State?
func enter() -> void:
	player.update_animation("idle")
	pass

## What happens when the player exits this State?
func exit() -> void:
	pass
	
## What happens constantly in this state?
func process( _delta : float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null
 
## What happens when physics get updated in this state?
func physics (_delta : float) -> State:
	return null
	
## What happens if we input events in this state?
func handle_input (_event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
	
