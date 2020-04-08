extends Node

export (PackedScene) var Mob
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func game_over():
	$DeathSound.play()
	$Music.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	score = 0
	$Music.play()
	$HUD.show_message('Get Ready!')
	$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
func _on_StartTimer_timeout():
	$HUD.update_score(score)
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	
func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.offset = randi()
	var mob = Mob.instance()
	add_child(mob)
	$HUD.connect('start_game',mob,'_on_start_game')
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.linear_velocity = Vector2(rand_range(mob.min_speed,mob.max_speed),0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)

