class_name LockedDoor extends Node2D

var is_open : bool = false

@export var key_item : ItemData #What type of item can open me?

@export var locked_audio : AudioStream
@export var open_audio : AudioStream

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var is_open_data: PersistentDataHandler = $PersistentDataHandler
@onready var interact_area: Area2D = $InteractArea2D



func _ready() -> void:
	interact_area.area_entered.connect( _on_area_entered )
	interact_area.area_exited.connect( _on_area_exited )
	
	pass


func _on_area_entered( _a : Area2D ) -> void:
	PlayerManager.interact_pressed.connect( open_door )
	pass
	
	
func _on_area_exited( _a : Area2D ) -> void:
	PlayerManager.interact_pressed.disconnect( open_door )
	pass

func open_door() -> void:
	if key_item == null:
		return
	var door_unlocked = false
	
	if door_unlocked:
		animation_player.play()
		audio.stream = open_audio
		is_open_data.set_value()
	else:
		audio.stream = locked_audio
	audio.play()
	pass
