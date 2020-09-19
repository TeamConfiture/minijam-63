extends ColorRect

func _on_LogoTimer_timeout():
	$AnimationPlayer.play("fade_in")
