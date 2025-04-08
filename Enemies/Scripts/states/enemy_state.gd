class_name EnemyState extends Node

## Stores a refrence to the enemy that this state belongs to
var enemy : Enemy
var state_machine : EnemyStateMachine

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
func process( _delta : float) -> EnemyState:
	return null

## What happens when physics get updated in this state?
func physics (_delta : float) -> EnemyState:
	return null
