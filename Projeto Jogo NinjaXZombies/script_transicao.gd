extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func passar_de_fase(anim_name):
	if (anim_name=="fim_de_fase"):
		ScriptGlobal.fase += 1
		var fase = ScriptGlobal.fase
		get_tree().change_scene("res://cena_fase" + str(fase) + ".tscn")
	
	
	
	
