extends Area2D
@export var conquest_name: String = "Uma Nova Conquista"
@export var fx_time: float = 0.18
@export var bonus_speed: float = 200.0
@export var bonus_duration: float = 5.0
@export var bonus_jump: float = -200
@export var bonus_jump_duration: float = 5.0

var collected := false

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.aumentar_speed(bonus_speed, bonus_duration)
		body.aumentar_pulo(bonus_jump, bonus_jump_duration)
		
	if collected:
		return
	
	collected = true
	conquest_generator(body.name, conquest_name)
	
	monitoring = false
	$collision.disabled = true
	
	var t := create_tween()
	t.tween_property(self, "scale", Vector2(1.25, 1.25), fx_time * 0.5)
	t.tween_property(self, "scale", Vector2.ZERO, fx_time * 0.5)
	await t.finished
	
	queue_free()

func conquest_generator(player: String, conquest: String) -> void:
	print("Jogador ", player, " recebeu a conquista: ", conquest)
