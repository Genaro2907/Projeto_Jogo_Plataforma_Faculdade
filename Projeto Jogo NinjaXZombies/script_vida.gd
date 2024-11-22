extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func GanharVidaExtrar(body):
	if (body.name=="Personagem" and ScriptGlobal.qtd_vidas<3):
		ScriptGlobal.qtd_vidas += 1
		get_parent().queue_free()




