extends Node2D

@onready var main_menu = $MainMenu
@onready var lute_game = $with_lute
@onready var juggle = $juggle
@onready var dish_bounce = $DishBounce
@onready var jester = $Jester

func _ready():
	main_menu.game_started.connect(start_game)
	InputManager.play_title.emit()
	
func start_game():
	InputManager.stop_title.emit()
	lute_game.start()

func _on_juggle_finished():
	jester.visible = false

