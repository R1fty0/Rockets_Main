extends Label
var time_elasped = 0.0 
var timer_digits = 4

func _ready():
	GameManager.game_ended.connect(send_final_score)

func _process(delta):
	# Update time elasped
	time_elasped += 1.0 * delta
	# Select amount of digits to show on timer 
	if time_elasped <= 99.9:
		timer_digits = 4
	if time_elasped > 99.9:
		timer_digits = 5
	if time_elasped > 999.9:
		timer_digits = 6
	if time_elasped > 9999.9:
		timer_digits = 7 
	# Update timer 
	text = str(time_elasped).left(timer_digits)
	
func send_final_score():
	GameManager.score = float(text)

