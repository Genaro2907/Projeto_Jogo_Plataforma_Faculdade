extends KinematicBody2D
var velocidade = 250
var gravidade  = 30
var forca_pulo = 770
var mov = Vector2.ZERO
var pulando  = false
var atacando = false
var direcao = 1
var deslizando = false

func _process(delta):
	mov.x = 0
	mov.y += gravidade
	
	if (not atacando):
		if (Input.is_action_pressed("ui_left")):
			mov.x = -velocidade
			$Sprite.flip_h = true
			direcao = -1
			
		elif (Input.is_action_pressed("ui_right")):
			mov.x = velocidade
			$Sprite.flip_h = false
			direcao = 1
		
		# Nova condição para deslizar no chão
		if (Input.is_action_pressed("ui_down") and is_on_floor()):
			deslizando = true
			# Reduz a velocidade de movimento quando deslizando
			mov.x = velocidade * 1.5 * direcao
			$AnimationPlayer.play("deslizando")
		else:
			deslizando = false
	
	if (Input.is_action_just_pressed("ui_up") and is_on_floor()):
		mov.y = -forca_pulo
	
	if (mov.x==0 and is_on_floor() and not atacando and not deslizando):
		$AnimationPlayer.play("parado")
	elif (mov.x!=0 and is_on_floor() and not atacando and not deslizando):
		$AnimationPlayer.play("andando")
	
	if (not is_on_floor()):
		if (not pulando):
			$AnimationPlayer.play("pulando")
			pulando  = true
			atacando = false
	else: 
		pulando = false
		
	if (is_on_floor() and Input.is_action_just_pressed("ui_accept")):
		$AnimationPlayer.play("atirando")
		atacando = true
	
	if ($AnimationPlayer.current_animation=="" or not is_on_floor()):
		atacando = false
		
	if (global_position.y>$Camera2D.limit_bottom):
		ScriptGlobal.resetar()
		get_tree().reload_current_scene()
		
	mov = move_and_slide(mov, Vector2(0,-1))

func disparar(anim_name):
	if (anim_name=="atirando"):
		var cena_disparo = preload("res://cena_disparo.tscn")
		var obj_disparo  = cena_disparo.instance()
		
		get_tree().root.add_child(obj_disparo)
		
		obj_disparo.get_node("Area2D").direcao = direcao
		
		if (direcao==1):
			obj_disparo.global_position = $Position2DDir.global_position
		elif (direcao==-1):
			obj_disparo.global_position = $Position2DEsq.global_position
