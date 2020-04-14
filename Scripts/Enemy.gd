extends KinematicBody

var state = ""
var speed = 1
onready var Scan = $Scanner
var health = 100 

func change_state(s):
	state = s
	var material = $spoopyghost/Sphere.mesh.surface_get_material(0)
	if state == "scanning":
		material.albedo_color = Color(0,1,0)
	if state == "found":
		material.albedo_color = Color(1,1,0)
	if state == "shooting":
		material.albedo_color = Color(1,0,0)
	$spoopyghost/Sphere.set_surface_material(0,material)

func _ready():
	change_state("searching")


func _physics_process(delta):
	if state == "searching":
		rotate(Vector3(0,1,0), speed*delta)
		var c = Scan.get_collider()
		if c != null and c.name == "Player":
			change_state("found")
	if state == "found":
		$Timer.start()
	if state == "shooting":
		pass


func _on_Timer_timeout():
	var c = Scan.get_collider()
	if c != null and c.name == "Player":
		if state == "found":
			change_state("shooting")
