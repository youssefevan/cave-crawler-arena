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


func _on_back_pressed():
	call_deferred("free")


func _on_button_toggled(toggled_on):
	OptionsManager.set_option("enable_fullscreen", toggled_on)
	OptionsManager.set_fullscreen(toggled_on)
