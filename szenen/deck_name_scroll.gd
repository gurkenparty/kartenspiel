extends ScrollContainer

@export var reference_button: Button  # Ensure this is a VBoxContainer
@export var container_space:Control
func _ready() -> void:
	# Ensure ScrollContainer expands to fill space
	self.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	self.size_flags_vertical = Control.SIZE_EXPAND_FILL

	# Ensure container_space (VBoxContainer) expands properly
	# Add test items to force scrolling

	update_scroll_size()

# Update the container size based on the number of children
func update_scroll_size():
	# Adjust the minimum size to be more flexible
	container_space.custom_minimum_size.y = max(200, container_space.get_child_count() * 50)  # Ensure it's at least 500px

# Function to add new items dynamically
func add_item(text: String):
	var card_btn = Button.new()
	card_btn.text = text
	card_btn.size = reference_button.size
	card_btn.scale = reference_button.scale
	card_btn.global_position = reference_button.position
	print_debug("Adding card: " + str(text) + " with position: " + str(card_btn.global_position) + " and size: " +str(card_btn.size))
	reference_button.global_position.y += 100
	card_btn.add_theme_font_size_override("font_size", 70)  # Make text smaller to fit in the layout
	container_space.add_child(card_btn)
	update_scroll_size()  # Update scrolling size
