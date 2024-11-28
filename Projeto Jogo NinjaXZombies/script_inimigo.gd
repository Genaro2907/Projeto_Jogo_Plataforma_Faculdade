extends KinematicBody2D

export var velocidade = 100
var gravidade = 20
var direita = true
var mov = Vector2.ZERO
export var qtd_vidas = 5
var atacando = false
var pode_atacar = true  
export var is_boss = false  

func _ready():
	var timer_ataque = Timer.new()
	if is_boss:
		timer_ataque.wait_time = 1.0 
	else:
		timer_ataque.wait_time = 2.0
	timer_ataque.one_shot = true
	timer_ataque.connect("timeout", self, "_on_TimerAtaque_timeout")
	add_child(timer_ataque)

func _process(delta):
	if qtd_vidas <= 0:
		return  
	
	mov.y += gravidade
	
	if not atacando and qtd_vidas > 0:
		if is_boss:
			mov = boss_behavior()  
		else:
			if not $RayCast2DEsq.is_colliding():
				direita = true
			if not $RayCast2DDir.is_colliding():
				direita = false
			
			if direita:
				$Sprite.flip_h = false
				mov.x = velocidade
			else:
				$Sprite.flip_h = true
				mov.x = -velocidade
	else:
		mov.x = 0
	
	mov = move_and_slide(mov)

func _on_body_entered(body):

	if body.is_in_group("player"): 
		causar_dano(body)

func causar_dano(body):
	if pode_atacar and qtd_vidas > 0:  
		if not atacando:
			atacando = true
			pode_atacar = false
			$AnimationPlayer.play("atacando" if not is_boss else "ataque_boss")
			body.get_node("AnimationPlayer2").play("dano")
			body.get_node("AudioDano").play()
			

			ScriptGlobal.qtd_vidas -= 1
			print("Vidas do jogador restantes: ", ScriptGlobal.qtd_vidas)
			

			if ScriptGlobal.qtd_vidas <= 0:
				print("Game Over!")
				get_tree().change_scene("res://cena_game_over.tscn")  
			else:
				$TimerAtaque.start()
				print("Inimigo causou dano ao jogador!")


func _on_TimerAtaque_timeout():
	
	pode_atacar = true
	atacando = false
	if qtd_vidas > 0:
		$AnimationPlayer.play("andando" if not is_boss else "boss_andando")

func perder_vida():
	qtd_vidas -= 1
	print("Vidas restantes do inimigo: ", qtd_vidas)
	
	if qtd_vidas <= 0:
		morrer()

func morrer():
	velocidade = 0
	if not $AnimationPlayer.is_playing() or $AnimationPlayer.current_animation != "morrendo":
		$AnimationPlayer.play("morrendo")
	$AudioMorrendo.play()

func boss_behavior():
	if not $RayCast2DEsq.is_colliding():
		direita = true
	if not $RayCast2DDir.is_colliding():
		direita = false
	
	if direita:
		$Sprite.flip_h = false
		return Vector2(velocidade, mov.y)
	else:
		$Sprite.flip_h = true
		return Vector2(-velocidade, mov.y)
