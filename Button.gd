extends Button  # Extend the appropriate base class (Button)
#comment
# Declare variables to store user input
export( NodePath ) onready var email = get_node(email) as LineEdit
export( NodePath ) onready var password = get_node(password) as LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect the "pressed" signal of the login button to the _on_Button_pressed function
	connect("pressed", self, "_on_Button_pressed")
	


func _on_Button_pressed():
	# Access the Firebase instance directly without using preload
	var firebase_instance = Firebase  # Assuming "Firebase" is the name of the singleton in firebase.gd
	
	# Access Firebase Auth service using the firebase_instance
	var auth_instance = firebase_instance.Auth
	# Get user input from LineEdit nodes
	
	
	if email.text.empty() or password.text.empty():
		print("Please enter both email and password.")
		return
	
	# Authenticate user using Firebase Auth
	auth_instance.login_with_email_and_password(email.text, password.text)
	
	# Connect to the success and failure signals
	auth_instance.connect("signin_success", self, "_on_signin_success")
	auth_instance.connect("signin_failed", self, "_on_signin_failed")

func _on_signin_success(user):
	print("Sign-in successful for user:", user.get_display_name())
	# Transition to the main game scene or perform other actions

func _on_signin_failed(error):
	print("Sign-in failed. Error:", error)
	# Display an error message to the user
