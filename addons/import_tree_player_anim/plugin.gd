tool
extends EditorPlugin
#signal save_animations
#signal import_animations
#signal load_animations
var current_object #the selected object
var animation_list #the list of animations (names)
var animation_array =[] #list of actual animations
var main_menu 

func _enter_tree():
	main_menu = preload("res://addons/import_tree_player_anim/MainMenu.tscn").instance()
	add_control_to_dock( DOCK_SLOT_LEFT_UR, main_menu)
	#connect( String signal, Object target, String method, Array binds=[  ], int flags=0 )
	main_menu.connect("save_animations", self, "_on_save_animations")
	main_menu.connect("import_animations", self, "_on_import_animations")
	main_menu.connect("load_animations", self, "_on_load_animations")
	


func _exit_tree():
	# Clean-up of the plugin goes here
	# Remove the scene from the docks:
	remove_control_from_docks( main_menu ) 
	main_menu.free() # Erase the control from the memory
	print ("dock removed and free-ed")

func handles(object):
	if (object is Node):
		return true


func edit(object):
	if (object is Node):
		current_object = object
		if (object is AnimationPlayer):
			main_menu.animations_load_ok(Color(0.4,0.6,0), "Animation Player Selected")
		elif (object is AnimationTreePlayer):
			main_menu.animations_load_ok(Color(0.4,0.6,0), "Animation Tree Player Selected")
		else:
			main_menu.animations_load_ok(Color(0.4,0.4,0), "Select an AnimationPlayer or AnimationTreePlayer")
	

func _on_save_animations():
	var error = 0
	if(current_object is AnimationPlayer):
		animation_list = current_object.get_animation_list()
		animation_array =[]
		var dir = Directory.new()
		if(not dir.dir_exists("res://animations")):
			dir.open("res://")
			dir.make_dir("animations")
		
		for i in range(0, animation_list.size()):
			animation_array.push_back(current_object.get_animation(animation_list[i]))
			
			var path = "res://animations/" + animation_list[i] + ".tres"
			
			print ("path: " , path)
			error = ResourceSaver.save(path, animation_array[i])
		if(animation_list and animation_array and error == 0):
			main_menu.animations_load_ok(Color(0,1,0), "Animations loaded and saved!")
		else:
			main_menu.animations_load_ok(Color(0.7,0.2,0), "There are no Animations!")
		if (error):
			print ("error saving animations:", error)
			main_menu.animations_load_ok(Color(0.7,0,0), "Animations not saved")

func _on_import_animations():
	if (current_object is AnimationTreePlayer):
		if (animation_list):
			for i in range(0, animation_list.size()):
				current_object.add_node(AnimationTreePlayer.NODE_ANIMATION, animation_list [i])
				current_object.animation_node_set_animation(animation_list[i],animation_array[i])
				main_menu.animations_load_ok(Color(0.1,1,0), "Animations Import OK!")
		else:
			print("first save animations!")
			main_menu.animations_load_ok(Color(0.8,0.3,0), "Can't import! There are no Animations!")

func _on_load_animations():
	if(current_object is AnimationPlayer):
		animation_list = current_object.get_animation_list()
		animation_array =[]
		for i in range(0, animation_list.size()):
			animation_array.push_back(current_object.get_animation(animation_list[i]))
		if(animation_list and animation_array):
			main_menu.animations_load_ok(Color(0,1,0), "Animations loaded! you can import animations in AnimationTreePlayer")
		else:
			main_menu.animations_load_ok(Color(0.7,0.2,0), "There are no Animations!")