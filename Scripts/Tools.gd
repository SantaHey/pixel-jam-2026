extends Node

class_name Tools

static var debug_enable = false
static var font_size = 7

static var displayed_texts: Dictionary = {}
static func showdebugtext(id, text):
	if not debug_enable: return

	# Mise à jour de la donnée (toujours faire ça en premier)
	displayed_texts[id] = str(text)

	var tree := Engine.get_main_loop() as SceneTree
	if not tree: return
	var root := tree.root

	# Create CanvasLayer
	var canvas = root.get_node_or_null("DebugCanvas")
	if not canvas:
		canvas = CanvasLayer.new()
		canvas.name = "DebugCanvas"
		root.add_child(canvas) # Utilise add_child direct si tu n'es pas dans un thread

	# // Label display
	var label : Label = canvas.get_node_or_null("DebugLabel")
	if not label:
		label = Label.new()
		label.name = "DebugLabel"
		label.position = Vector2(10, 10)
		label.add_theme_color_override("font_color", Color.RED)
		label.add_theme_font_size_override("font_size", font_size)
		canvas.add_child(label)

	# 3. Construction du texte final
	var final_string = ""
	var keys = displayed_texts.keys()
	keys.sort() # Trie les clés par ordre alphabétique
	
	for key in keys:
		final_string += str(key) + " : " + str(displayed_texts[key]) + "\n"
	
	label.text = final_string

	label.text = final_string
