extends Node

onready var music = $BGM

var play_position = 0.0

func play():
	music.play(play_position)

func stop():
	play_position = music.get_playback_position()
	music.stop()
