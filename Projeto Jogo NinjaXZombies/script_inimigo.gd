extends KinematicBody2D

export var velocidade = 100
var gravidade  = 20
var direita    = true
var mov        = Vector2.ZERO
export var qtd_vidas  = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Comando para desabilitar um collisionShape via código
	#$Area2D/CollisionShape2D.set_deferred("disabled",true)
	
	
	mov.y += gravidade
	
	if (not $RayCast2DEsq.is_colliding()):
		direita = true
	if (not $RayCast2DDir.is_colliding()):
		direita = false
	
	if (direita):
		$Sprite.flip_h = false
		mov.x = velocidade
	else:
		$Sprite.flip_h = true
		mov.x = -velocidade
		
	mov = move_and_slide(mov)
	
	
func causar_dano(body):
	body.get_node("AnimationPlayer2").play("dano")
	body.get_node("AudioDano").play()
	ScriptGlobal.qtd_vidas -= 1
	
	if (ScriptGlobal.qtd_vidas==0):	
		get_tree().change_scene("res://cena_game_over.tscn")
	

func kill(anim_name):
	if (anim_name=="morrendo"):
		get_parent().queue_free()

func perder_vida():
	qtd_vidas-=1
	if (qtd_vidas<1):
		velocidade = 0
		$AnimationPlayer.play("morrendo")
		$AudioMorrendo.play()

