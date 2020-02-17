extends Spatial

# variables:
var pitch = -30.0
var yaw = -45.0
var w_mod = Vector3(0, 0, 0)
var a_mod = Vector3(0, 0, 0)
var s_mod = Vector3(0, 0, 0)
var d_mod = Vector3(0, 0, 0)
var size = 15
var pos = Vector3(0, 0, 0)
var arena_size = 15
var rotat = int(fmod(self.yaw,360.0)/45)
var size_t = 15

# const:
const d = .25
const ROTATION_SPEED = 6.0
const MOVEMENT_SPEED = 6.0

# functions:
func logic(var delta, var pawn):
	self._follow_pawn(delta, pawn)
	self._rotate_arround(delta)
	return self._get_selected_tile()

# aux functions:
func _follow_pawn(var delta, var pawn):
	return

func update_rotat():
	if rotat == 0:
		w_mod = Vector3(0, 0, -1*d)
		a_mod = Vector3(-1*d, 0, 0)
		s_mod = Vector3(0, 0, 1*d)
		d_mod = Vector3(1*d, 0, 0)
	elif rotat == -1 or rotat == 7:
		w_mod = Vector3((1/sqrt(2))*d, 0, -(1/sqrt(2))*d)
		a_mod = Vector3(-(1/sqrt(2))*d, 0, -(1/sqrt(2))*d)
		s_mod = Vector3(-(1/sqrt(2))*d, 0, (1/sqrt(2))*d)
		d_mod = Vector3((1/sqrt(2))*d, 0, (1/sqrt(2))*d)
	elif rotat == -2 or rotat == 6:
		a_mod = Vector3(0, 0, -1*d)
		s_mod = Vector3(-1*d, 0, 0)
		d_mod = Vector3(0, 0, 1*d)
		w_mod = Vector3(1*d, 0, 0)
	elif rotat == -3 or rotat == 5:
		a_mod = Vector3((1/sqrt(2))*d, 0, -(1/sqrt(2))*d)
		s_mod = Vector3(-(1/sqrt(2))*d, 0, -(1/sqrt(2))*d)
		d_mod = Vector3(-(1/sqrt(2))*d, 0, (1/sqrt(2))*d)
		w_mod = Vector3((1/sqrt(2))*d, 0, (1/sqrt(2))*d)
	elif rotat == 4 or rotat == -4:
		s_mod = Vector3(0, 0, -1*d)
		d_mod = Vector3(-1*d, 0, 0)
		w_mod = Vector3(0, 0, 1*d)
		a_mod = Vector3(1*d, 0, 0)
	elif rotat == -5 or rotat == 3:
		s_mod = Vector3((1/sqrt(2))*d, 0, -(1/sqrt(2))*d)
		d_mod = Vector3(-(1/sqrt(2))*d, 0, -(1/sqrt(2))*d)
		w_mod = Vector3(-(1/sqrt(2))*d, 0, (1/sqrt(2))*d)
		a_mod = Vector3((1/sqrt(2))*d, 0, (1/sqrt(2))*d)
	elif rotat == -6 or rotat == 2:
		d_mod = Vector3(0, 0, -1*d)
		w_mod = Vector3(-1*d, 0, 0)
		a_mod = Vector3(0, 0, 1*d)
		s_mod = Vector3(1*d, 0, 0)
	elif rotat == -7 or rotat == 1:
		d_mod = Vector3((1/sqrt(2))*d, 0, -(1/sqrt(2))*d)
		w_mod = Vector3(-(1/sqrt(2))*d, 0, -(1/sqrt(2))*d)
		a_mod = Vector3(-(1/sqrt(2))*d, 0, (1/sqrt(2))*d)
		s_mod = Vector3((1/sqrt(2))*d, 0, (1/sqrt(2))*d)

func _input(event):
	if Input.is_key_pressed(KEY_W):
		update_rotat()
		pos = self.get_translation() + w_mod * MOVEMENT_SPEED
		pos.x = clamp(pos.x, -arena_size, arena_size)
		pos.z = clamp(pos.z, -arena_size, arena_size)
	if Input.is_key_pressed(KEY_A):
		update_rotat()
		pos = self.get_translation() + a_mod * MOVEMENT_SPEED
		pos.x = clamp(pos.x, -arena_size, arena_size)
		pos.z = clamp(pos.z, -arena_size, arena_size)
	if Input.is_key_pressed(KEY_S):
		update_rotat()
		pos = self.get_translation() + s_mod * MOVEMENT_SPEED
		pos.x = clamp(pos.x, -arena_size, arena_size)
		pos.z = clamp(pos.z, -arena_size, arena_size)
	if Input.is_key_pressed(KEY_D):
		update_rotat()
		pos = self.get_translation() + d_mod * MOVEMENT_SPEED
		pos.x = clamp(pos.x, -arena_size, arena_size)
		pos.z = clamp(pos.z, -arena_size, arena_size)
	if Input.is_action_just_pressed("zoom_in"):
		self.size -= 5
	if Input.is_action_just_pressed("zoom_out"):
		self.size += 5
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			self.size -= 1.5
		if event.button_index == BUTTON_WHEEL_DOWN:
			self.size += 1.5
	self.size = clamp(self.size, 10, 25)

func _rotate_arround(var delta):
	if Input.is_action_pressed("cont_up"):
		update_rotat()
		pos = self.get_translation() + w_mod * MOVEMENT_SPEED
		pos.x = clamp(pos.x, -arena_size, arena_size)
		pos.z = clamp(pos.z, -arena_size, arena_size)
	if Input.is_action_pressed("cont_left"):
		update_rotat()
		pos = self.get_translation() + a_mod * MOVEMENT_SPEED
		pos.x = clamp(pos.x, -arena_size, arena_size)
		pos.z = clamp(pos.z, -arena_size, arena_size)
	if Input.is_action_pressed("cont_down"):
		update_rotat()
		pos = self.get_translation() + s_mod * MOVEMENT_SPEED
		pos.x = clamp(pos.x, -arena_size, arena_size)
		pos.z = clamp(pos.z, -arena_size, arena_size)
	if Input.is_action_pressed("cont_right"):
		update_rotat()
		pos = self.get_translation() + d_mod * MOVEMENT_SPEED
		pos.x = clamp(pos.x, -arena_size, arena_size)
		pos.z = clamp(pos.z, -arena_size, arena_size)
	if Input.is_action_just_pressed("ui_left"):
		self.yaw -= 45.0
	if Input.is_action_just_pressed("ui_right"):
		self.yaw += 45.0
	if Input.is_action_just_pressed("ui_up"):
		self.pitch -= 15.0
		if self.pitch < -75.0:
			self.pitch = -15.0
	if Input.is_action_just_pressed("ui_down"):
		self.pitch += 15.0
		if self.pitch > -15.0:
			self.pitch = -75.0
	var from = self.get_rotation()
	var to = Vector3(deg2rad(self.pitch), deg2rad(self.yaw), 0.0)
	if from != to:
		var euler = from.linear_interpolate(to, delta * ROTATION_SPEED)
		self.set_rotation(euler)
		rotat = int(fmod(self.yaw,360.0)/45)
	if self.get_translation() != pos:
		self.set_translation(self.get_translation().linear_interpolate(pos, delta * MOVEMENT_SPEED))
	if size_t != size:
		if size > size_t:
			self.get_child(0).set_size(get_child(0).get_size()+d)
			size_t = get_child(0).get_size()
		else:
			self.get_child(0).set_size(get_child(0).get_size()-d)
			size_t = get_child(0).get_size()

func _get_selected_tile():
	if Input.is_action_just_pressed("ui_accept"):
		var tap = get_viewport().get_mouse_position()
		var from = $Camera.project_ray_origin(tap)
		var to = from + $Camera.project_ray_normal(tap) * 10000
		var space_state = get_world().direct_space_state
		return space_state.intersect_ray(from, to, [], 1).get("collider")
	return null