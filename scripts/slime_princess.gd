extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer  # ✅ Referencia al Timer

signal player_died
const SPEED = 70.0
var direction = -1.0

func _ready() -> void:
	# ✅ Conectar el timer por código
	timer.timeout.connect(_on_timer_timeout)
	timer.start()  # ✅ Asegurarse de que inicie

func _process(delta: float) -> void:
	position.x += direction * SPEED * delta

func _on_timer_timeout() -> void:
	direction *= -1
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and body.alive:
		emit_signal("player_died", body)
