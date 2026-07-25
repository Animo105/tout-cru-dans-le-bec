extends Control
@onready var accueil: PanelContainer = %Accueil
@onready var deshydratage: PanelContainer = %Deshydratage
@onready var historique: PanelContainer = %Historique
@onready var reception: PanelContainer = %Reception
@onready var stock_deshydrate: PanelContainer = %StockDeshydrate
@onready var transformation: PanelContainer = %Transformation
@onready var trempage: PanelContainer = %Trempage
@onready var admin_panel: PanelContainer = %AdminPanel



@onready var admin_button: Button = $VBoxContainer/MarginContainer/HBoxContainer/NavBarContainer/MarginContainer/VBoxContainer/AdminButton

const ACCUEIL = preload("uid://gk3umo4mao5w")

var scenes: Array[Control]

var current_scene : Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.show_acceuil.connect(_on_accueil_pressed)
	admin_button.visible = Globals.is_admin
	scenes = [
		accueil,
		deshydratage,
		historique,
		reception,
		stock_deshydrate,
		transformation,
		trempage,
		admin_panel
	]

func hideAll() -> void:
	for x in scenes:
		x.hide()

func _on_accueil_pressed() -> void:
	hideAll()
	accueil.show()


func _on_deshydratage_pressed() -> void:
	hideAll()
	deshydratage.show()


func _on_reception_pressed() -> void:
	hideAll()
	reception.show()


func _on_trempage_pressed() -> void:
	hideAll()
	trempage.show()


func _on_stock_deshydrate_pressed() -> void:
	hideAll()
	stock_deshydrate.show()

func _on_transformation_pressed() -> void:
	hideAll()
	transformation.show()

func _on_historique_pressed() -> void:
	hideAll()
	historique.show()

func _on_admin_button_pressed() -> void:
	hideAll()
	admin_panel.show()

func _on_deconexion_pressed() -> void:
	pass
	#SceneManager.load_previous_scene()
