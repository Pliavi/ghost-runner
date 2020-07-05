extends Node

func _ready():
	$hiscore.text = "%05d" % Globals.high_score

func _process(delta):
	$score.text = "%05d" % Globals.score
