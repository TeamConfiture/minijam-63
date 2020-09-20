extends ColorRect

func _ready():
	OS.window_fullscreen = true

func _on_LogoTimer_timeout():
	$AnimationPlayer.play("fade_in")

func _on_AnimationPlayer_animation_finished(anim_name):
	Global.goto_scene("res://Global/Menus/MainMenu.tscn")
