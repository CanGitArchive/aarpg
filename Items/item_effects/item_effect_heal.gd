class_name ItemEffectHeal extends ItemEffect


@export var heal_amount : int = 1
@export var audio : AudioStream


func use() -> void:
	PlayerManager.player.update_hp( heal_amount )
	PauseMenu.audio_stream_player.volume_db = -27
	PauseMenu.play_audio( audio )
	
	await PauseMenu.audio_stream_player.finished
	
	PauseMenu.audio_stream_player.volume_db = 0
