class_name HitBox extends Area2D

signal damaged( hurt_box : HurtBox )
signal damaged_by( source : Node) 

func _take_damage( hurt_box : HurtBox ) -> void:
	damaged.emit( hurt_box )
	damaged_by.emit( hurt_box.enemy_owner )


	
