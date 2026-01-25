extends Control

func _ready():
	$Content/Options/Container/SFX/Slider.value = OptionsManager.options["volume_sfx"]
	$Content/Options/Container/Music/Slider.value = OptionsManager.options["volume_music"]

func _on_sfx_volume_changed(value):
	AudioManager.set_volume_sfx(value)
	OptionsManager.set_option("volume_sfx", value)

func _on_music_volume_changed(value):
	AudioManager.set_volume_music(value)
	OptionsManager.set_option("volume_music", value)
