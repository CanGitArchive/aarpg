class_name HurtBox extends Area2D

@export var damage : int = 1
@export var enemy_owner : Node = null

func _ready() -> void:
	area_entered.connect( AreaEntered )
	
func AreaEntered(a : Area2D) -> void:
	if a is HitBox:
		a._take_damage( self )
	pass
	
