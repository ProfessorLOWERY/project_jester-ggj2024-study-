extends Node2D

@export var okay_mood: float = 0.5
@export var good_mood: float = 0.7

@export var fail_face: int
@export var oof_face: int
@export var okay_face: int
@export var good_face: int

@onready var animation_player: = $AnimationPlayer as AnimationPlayer

@onready var catch_hands = $CatchHands
@onready var high_catch_hands: = $CatchHands/HighCatchHands as CollisionShape2D
@onready var middle_catch_hands = $CatchHands/MiddleCatchHands as CollisionShape2D
@onready var low_catch_hands = $CatchHands/LowCatchHands as CollisionShape2D
@onready var faces: = $Body/Head/Faces as Sprite2D

var _mood: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	InputManager.action_pressed.connect(handle_input_pressed)
	InputManager.action_released.connect(handle_input_released)
	catch_middle() # Start in the middle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_mood(m: float):
	_mood = m
	update_face()

func update_face():
	if _mood > good_mood:
		faces.frame = good_face
	elif _mood > okay_mood:
		faces.frame = okay_face
	else:
		faces.frame = oof_face

func bounce_dish(dish: Area2D):
	if dish.has_method("bounce"):
		dish.bounce()

func handle_input_pressed(input: String):
	if input == "r_up":
		catch_high()
	elif input == "r_down":
		catch_low()

func handle_input_released(input: String):
	if input == "r_up" or input == "r_down":
		catch_middle()

func catch_low():
	animation_player.play("catch_low")
	low_catch_hands.disabled = false
	middle_catch_hands.disabled = true
	high_catch_hands.disabled = true

func catch_middle():
	animation_player.play("catch_middle")
	low_catch_hands.disabled = true
	middle_catch_hands.disabled = false
	high_catch_hands.disabled = true

func catch_high():
	animation_player.play("catch_high")
	low_catch_hands.disabled = true
	middle_catch_hands.disabled = true
	high_catch_hands.disabled = false

