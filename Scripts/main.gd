extends Control


var Card = preload("res://Scenes/card.tscn")


@onready var deck : Control = $Deck
@onready var hand : Control = $Hand


# Called when the node enters the scene tree for the first time.
func _ready():
	deck.cardDrawn.connect(OnCardDrawn)


func OnCardDrawn(_d : Dictionary) -> void:
	var d : Dictionary = _d.duplicate()
	var c = Card.instantiate()
	var n : int = hand.get_child_count()
	var offset : int = 60
	hand.add_child(c)
	c.position = Vector2(n*offset,0)
	c.SetData(d)
	print("Added to hand: ", d["name"])
