extends Control


var Card = preload("res://Scenes/card.tscn")


@onready var deck : Control = $Deck
@onready var hand : Control = $Hand

var offset : int = 125
# Called when the node enters the scene tree for the first time.
func _ready():
	deck.cardDrawn.connect(OnCardDrawn)


func OnCardDrawn(_d : Dictionary) -> void:
	#var handSize : int = 1038
	var windowWidth : int = 1920
	var maxHandWidth : int = 1200#1373
	var cardSize : int = 123
	var d : Dictionary = _d.duplicate()
	var c = Card.instantiate()
	var n : int = 0#hand.get_child_count()#+1
	
	# Add a card to the hand
	c.isShown = true
	c.isInDeck = false
	hand.add_child(c)
	n = hand.get_child_count()
	c.position = Vector2((n-1)*offset,0)
	c.SetData(d)
	print("Added to hand: ", d["name"])
	
	# Calculate hand size
	hand.size.x = n * cardSize + (n-1) * (offset - cardSize)
	
	# If hand size is too large, reduce it's side and calculate new size until hand size less than maximum
	while hand.size.x >= maxHandWidth:
		offset -= 1
		for i in range(0, hand.get_child_count(), 1):
			hand.get_child(i).position.x = i*offset
		hand.size.x = n * cardSize + (n-1) * (offset - cardSize)
	# Center the hand
	hand.position.x = int(windowWidth / 2) - int(hand.size.x / 2)
