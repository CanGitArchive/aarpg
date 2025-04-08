class_name  State extends Node
static var player: Player
static var state_machine : PlayerStateMachine

func _ready() -> void:
	pass

## What happens when we initialize this state?
func init() -> void:
	pass
	
## What happens when the player enters theis State?
func enter() -> void:
	pass

## What happens when the player exits this State?
func exit() -> void:
	pass
	
## What happens constantly in this state?
func process( _delta : float) -> State:
	return null

## What happens when physics get updated in this state?
func physics (_delta : float) -> State:
	return null
	
## What happens if we input events in this state?
func handle_input (_event: InputEvent) -> State:
	return null
	
