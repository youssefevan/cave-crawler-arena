extends Node

var bus_index_sfx = AudioServer.get_bus_index("SFX")
var bus_index_music = AudioServer.get_bus_index("Music")

var current_streams = []

var interrupted_music
var interrupt_position

@onready var music_player = $MusicPlayer

func _ready():
	music_player.set_bus("Music")
	
	OptionsManager.connect("data_loaded", load_audio_data)

func play_sfx(sound : AudioStream, base_pitch := 1.0, pitch_range := 0.0, parent := get_tree().current_scene):
	var stream = AudioStreamPlayer.new()
	
	stream.set_bus("SFX")
	stream.stream = sound
	stream.pitch_scale = randf_range(base_pitch - pitch_range, base_pitch + pitch_range)
	
	stream.connect("finished", Callable(stream, "queue_free"))
	
	var can_play = true
	for i in get_children():
		if i is AudioStreamPlayer and i.stream == sound:
			i.stop()
			i.pitch_scale = randf_range(base_pitch - pitch_range, base_pitch + pitch_range)
			i.play()
			can_play = false
	if can_play:
		add_child(stream)
		stream.play()

func play_music(music: AudioStream, interrupt: bool):
	if music_player.stream != music:
		
		if interrupt == true:
			interrupted_music = music_player.stream
			interrupt_position = music_player.get_playback_position()
		
		music_player.stream = music
		music_player.play()

func resume_music():
	music_player.stream = interrupted_music
	music_player.play(interrupt_position)

func clear_sfx(sfx: AudioStream):
	for i in get_children():
		if i.stream == sfx:
			i.stop()
			i.call_deferred("queue_free")

func load_audio_data():
	set_volume_sfx(OptionsManager.options["volume_sfx"])
	set_volume_music(OptionsManager.options["volume_music"])

func set_volume_sfx(value):
	var vol = value - 4.0
	AudioServer.set_bus_volume_db(bus_index_sfx, linear_to_db(vol))

func set_volume_music(value):
	var vol = value - 4.0
	AudioServer.set_bus_volume_db(bus_index_music, linear_to_db(vol))
