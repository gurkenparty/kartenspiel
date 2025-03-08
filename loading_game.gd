extends Control

const TARGET_SCENE_PATH = "res://szenen/game_3d.tscn"
var loading_status : int
var progress : Array[float]

@onready var progress_bar : ProgressBar = $ProgressBar

func _ready() -> void:
	# Start loading the target scene asynchronously
	ResourceLoader.load_threaded_request(TARGET_SCENE_PATH)

func _process(_delta: float) -> void:
	# Update loading status
	loading_status = ResourceLoader.load_threaded_get_status(TARGET_SCENE_PATH, progress)

	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			# Update progress bar value
			progress_bar.value = progress[0] * 100
		ResourceLoader.THREAD_LOAD_LOADED:
			# Once loaded, change to the target scene
			get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(TARGET_SCENE_PATH))
		ResourceLoader.THREAD_LOAD_FAILED:
			# Handle loading error
			print("Error loading scene")
