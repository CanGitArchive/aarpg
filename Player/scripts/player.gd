class_name Player extends CharacterBody2D

signal DirectionChanged( new_direction: Vector2)
signal player_damaged( hurt_box : HurtBox)

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hit_box: HitBox = $HitBox

var invulnerable : bool = false
var hp : int = 6
var max_hp = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerManager.player = self
	state_machine.Initialize(self)
	hit_box.damaged.connect( _take_damage )
	if(ArduinoConnectionNode.arduinoConnected == true):
		hit_box.damaged_by.connect( _trigger_arduino )
	update_hp( 99 )
	pass # Replace with function body.


func _process(_delta):
	
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	#direction = direction.normalized()
	
	direction = Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up", "down")
	).normalized()
	
	
	
	pass

func _physics_process(_delta):
	move_and_slide()
	
func set_direction() -> bool:
	
	if direction == Vector2.ZERO:
		return false
		
	#if direction.y == 0: ## if you aren't moving up or down
		#new_dir = Vector2.LEFT if direction.x == -1 else Vector2.RIGHT
	#elif direction.x == 0: ## if you aren't moving left or right
		#new_dir = Vector2.UP if direction.y == -1 else Vector2.DOWN
	
	var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_dir = DIR_4[ direction_id ]
	
	if new_dir == cardinal_direction: ## if you are still in the same direction, keep it
		return false
	
	DirectionChanged.emit( new_dir )
	
	cardinal_direction = new_dir
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	
		
	return true

func update_animation(state: String) -> void:
	animation_player.play(state + "_" + AnimDirection())
	pass

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage( hurt_box : HurtBox) -> void:
	if invulnerable == true:
		return
	update_hp( -hurt_box.damage )
	if hp > 0:
		player_damaged.emit( hurt_box )
	else:
		player_damaged.emit( hurt_box )
		update_hp( 99 )
	pass
	
func update_hp( _delta : int ) -> void:
	hp = clampi( hp + _delta, 0, max_hp )
	PlayerHud.update_hp( hp, max_hp )
	pass
	
func make_invulnerable(_duration : float = 1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false

	await get_tree().create_timer(_duration).timeout
	invulnerable = false
	hit_box.monitoring = true

	
func _trigger_arduino(source : Node) -> void:
	if source.name == "Slime":
		var slime_motor_duration = 5.0
		ArduinoData.arduino_messege("100") 
		await get_tree().create_timer(slime_motor_duration).timeout
		ArduinoData.arduino_messege("0") 
		
