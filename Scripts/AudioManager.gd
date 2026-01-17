extends AudioStreamPlayer

func _ready():
	volume_db = -12

func play_audio(audio : AudioStream):
	stream = audio
	play()