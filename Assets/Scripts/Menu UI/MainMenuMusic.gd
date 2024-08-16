extends AudioStreamPlayer2D

const level_music = preload("res://Assets/Audio/Music/ominous-tension-157906.mp3")

func _ready():
	play_music_level()  # Ensure music plays every time the scene is ready

func _play_music(music: AudioStream, volume = 0.0):
	if stream != music:  # Only change if the stream is different
		stream = music
		volume_db = volume
		play()
	elif !is_playing():  # If the music is not currently playing, play it again
		play()

func play_music_level():
	_play_music(level_music)

func stop_music():
	if is_playing():
		stop()
