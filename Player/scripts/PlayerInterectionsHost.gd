class_name PlayerInteractionsHost extends Node2D

@onready var player: Player = $".."

func _ready() -> void:
	player.DirectionChanged.connect( UpdateDirection )

func UpdateDirection (new_direction : Vector2) -> void:

	match new_direction:
		Vector2.DOWN:
			position = Vector2(0, -10)
		Vector2.UP:
			position = Vector2(0, -45)
		Vector2.LEFT:
			position = Vector2(-20, -20)
		Vector2.RIGHT:
			position = Vector2(20, -20)
		_:
			position = Vector2(0, -10)
