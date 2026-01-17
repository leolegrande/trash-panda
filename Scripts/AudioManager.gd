extends AudioStreamPlayer

func _ready():
	volume_db = -20

func play_audio(audio : AudioStream):
	stream = audio
	play()
