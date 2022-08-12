extends Node

onready var audioPlayers = $AudioPlayers

var current = 0

func is_playing(sfx: AudioStream):
	for audioPlayer in audioPlayers.get_children():
		if audioPlayer.stream == sfx and audioPlayer.playing:
			return true
	return false

func play_sfx(sfx: AudioStream, unique=true):
	if unique and is_playing(sfx):
		return
	var audioPlayer: AudioStreamPlayer = audioPlayers.get_children()[current]
	audioPlayer.stream = sfx
	audioPlayer.play()
	current = (current + 1) % audioPlayers.get_child_count()
