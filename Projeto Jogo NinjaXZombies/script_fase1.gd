extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ParallaxBackground/HUD/Sprite.visible = false
	$ParallaxBackground/HUD/Sprite2.visible = false
	$ParallaxBackground/HUD/Sprite3.visible = false
	if (ScriptGlobal.qtd_vidas==3):
		$ParallaxBackground/HUD/Sprite.visible = true
		$ParallaxBackground/HUD/Sprite2.visible = true
		$ParallaxBackground/HUD/Sprite3.visible = true
	elif (ScriptGlobal.qtd_vidas==2):
		$ParallaxBackground/HUD/Sprite.visible = true
		$ParallaxBackground/HUD/Sprite2.visible = true
	elif (ScriptGlobal.qtd_vidas==1):	
		$ParallaxBackground/HUD/Sprite.visible = true
		
		


