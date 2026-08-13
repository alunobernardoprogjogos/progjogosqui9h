extends CharacterBody2D


var is_jumping := false
@onready var animation := $anim as AnimatedSprite2D
#@export var speed_bonus: float = 200.0
@export var base_speed: float = 300.0
@export var base_jump_force: float = -400.0
var SPEED: float
var JUMP_FORCE: float
var direction

#var current_speed: float
var speed_timer: Timer

func _ready() -> void:
	SPEED = base_speed 
	JUMP_FORCE = base_jump_force

	speed_timer = Timer.new()
	speed_timer.one_shot = true
	speed_timer.timeout.connect(_on_speed_jump_timer_timeout)
	add_child(speed_timer)
	
func _physics_process(delta: float) -> void:
	# Aplicar a gravidade.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Tratar o pulo.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = base_jump_force

	# Atualizar o estado de pulo com base no contato com o chão
	is_jumping = not is_on_floor()

	# Ler a direção de entrada e tratar movimento/desaceleração.
	# Como boa prática, substitua ações de UI por ações específicas do jogo.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
	else:
		# Aplicar desaceleração horizontal mesmo durante o pulo
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	_set_state()
	move_and_slide()

func _set_state():
	var state = "idle"
	
	if !is_on_floor(): # if is_on_floor == false
		state = "jump"
	elif direction != 0:
		state = "run"
		
	if animation.name!= state:
		animation.play(state)
		
func aumentar_speed(valor: float, duracao: float):
	SPEED = base_speed + valor
	print("🚀 Speed aumentada para:", SPEED)
	speed_timer.start(duracao)
	
func aumentar_pulo(valor: float, duracao: float):
	JUMP_FORCE = base_jump_force + valor
	print("🚀 Jump Force aumentado para:", JUMP_FORCE)
	speed_timer.start(duracao)
	
func _on_speed_jump_timer_timeout():
	SPEED = base_speed
	JUMP_FORCE = base_jump_force
	print("⏳ Speed voltou para:", SPEED)
	print("⏳ O Jump Force voltou para:", JUMP_FORCE)
	
