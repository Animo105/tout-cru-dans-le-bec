extends Control
@onready var accueil: Control = $Background/VBoxContainer/MarginContainer/HBoxContainer/SceneContainer/MarginContainer/Control
@onready var deshydratage: Control = $Background/VBoxContainer/MarginContainer/HBoxContainer/SceneContainer/MarginContainer/Deshydratage

@onready var scenes: Array[Control] = [accueil, deshydratage]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hideAll() -> void:
	for x in scenes:
		x.hide()

func _on_accueil_pressed() -> void:
	hideAll()
	accueil.show()


func _on_deshydratage_pressed() -> void:
	hideAll()
	deshydratage.show()
