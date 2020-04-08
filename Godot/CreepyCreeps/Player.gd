extends Area2D

signal hit

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 400 # pixels/sec of player
var screen_size # screen size of game

# Called when the node enters the scene tree for the first time.
func _ready():
	#pass # Replace with function body.
	screen_size = get_viewport_rect().size
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2() #player's move vec
	if Input.is_action_just_pressed("ui_up"):
		velocity.y += -1
	if Input.is_action_just_pressed("ui_down"):
		velocity.y +=  1
	if Input.is_action_just_pressed("ui_left"):
		velocity.x += -1
	if Input.is_action_just_pressed("ui_right"):
		velocity.x +=  1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
		#get_node("AnimatedSprite").play()
	else:
		$AnimatedSprite.stop()
	
	# update position
	position += velocity * delta
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)
	
	#Animation
	if velocity.x != 0 :
		$AnimatedSprite.animation = 'right'
		$AnimatedSprite.flip_v = false 
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y !=0 :
		$AnimatedSprite.animation = 'up'
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.flip_v = velocity.y > 0
		



func _on_Player_body_entered(_body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred('disabled',true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

