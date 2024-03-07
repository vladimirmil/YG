extends Control

signal pressed


@onready var backside : TextureRect = $Back
# SHARED
@onready var frame : TextureRect = $Frame
@onready var nameLabel : Label = $Frame/Name
@onready var artSprite : TextureRect = $Frame/Art
@onready var attributeSprite : TextureRect = $Frame/Attribute
# MONSTER
@onready var monsterControl : Control = $Frame/Monster
@onready var levelSprite : Sprite2D = $Frame/Monster/Level
@onready var descriptionMLabel : RichTextLabel = $Frame/Monster/Description
@onready var raceLabel : Label = $Frame/Monster/Race
@onready var atkLabel : Label = $Frame/Monster/Atk
@onready var defLabel : Label = $Frame/Monster/Def
# SPELL/TRAP
@onready var SpellTrapControl : Control = $Frame/SpellTrap
@onready var descriptionSTLabel : RichTextLabel = $Frame/SpellTrap/Description
@onready var spellTrapLabel : Label = $Frame/SpellTrap/Type

var typeDir : String = "res://Images/Frame/"
var artworkDir : String = "res://Images/Artwork/"
var attributeDir : String = "res://Images/Attribute/"
var data : Dictionary = {
	"id"        : "",
	"name"      : "",
	"type"      : "",
	"desc"      : "",
	"atk"       : 0,
	"def"       : 0,
	"level"     : 8,
	"attribute" : "",
	"race"      : "",
	"art"       : ""
}

var isShown : bool = true


func _ready():
	#SetData(
	#	{'id': 50045299, 'name': 'Dragon Capture Jar', 'type': 'trap', 'desc': 'Change all face-up Dragon-Type monsters on the field to Defense Position, also they cannot change their battle positions.', 'atk': 0, 'def': 0, 'level': 0, 'race': '', 'attribute': ''}
	#)
	$Button.mouse_entered.connect(OnMouseEntered)
	$Button.mouse_exited.connect(OnMouseExited)
	frame.visible = isShown



func SetData(_data : Dictionary) -> void:
	var artwork : Object = null
	var attribute : Object = null
	var type : Object = null
	
	# SET DATA
	data = _data.duplicate()
	
	# SET TYPE SPECIFIC DATA
	if data["type"] == "spell":
		data["attribute"] = "SPELL"
		descriptionSTLabel.text = data["desc"]
		spellTrapLabel.text = "[ Spell Card ]"
		monsterControl.visible = false
		SpellTrapControl.visible = true
	elif data["type"] == "trap":
		data["attribute"] = "TRAP"
		descriptionSTLabel.text = data["desc"]
		spellTrapLabel.text = "[ Trap Card ]"
		monsterControl.visible = false
		SpellTrapControl.visible = true
	else:
		monsterControl.visible = true
		SpellTrapControl.visible = false
		raceLabel.text = data["race"]
		atkLabel.text = "ATK/" + str(data["atk"])
		defLabel.text = "DEF/" + str(data["def"])
		levelSprite.frame = levelSprite.vframes - data["level"]
		descriptionMLabel.text = data["desc"]
		
	# LOAD IMAGES
	artwork = load(artworkDir + str(data["id"]) + ".jpg")
	attribute = load(attributeDir + data["attribute"] + ".png")
	type = load(typeDir + data["type"] + ".png")
	
	# SET SHARED DATA
	artSprite.texture = artwork
	attributeSprite.texture = attribute
	frame.texture = type
	nameLabel.text = data["name"]


func _on_button_pressed():
	emit_signal("pressed")
	#queue_free()


func OnMouseEntered() -> void:
	z_index = 1
	#print("entered")

func OnMouseExited() -> void:
	z_index = 0
	#print("exited")




