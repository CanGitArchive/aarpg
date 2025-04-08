extends Node

# Define your dictionary
var arduinoEventLabel : Dictionary = {
	"0": "0",
	"100": "1",
	"150": "2",
	"200": "3",
	"250": "4",
	"Zap 1000/100": "5",
	"Zap 1000/200": "6",
	"Zap 1000/300": "7",
	"Zap 1000/400": "8",
	"Pulse 500/2000/150": "9",
	"Pulse 500/1000/150": "10",
	"Pulse 250/500/150": "11",
	"Pulse 125/250/150": "12",
	"Gradual 1Sec": "13",
	"Sine wave 1Sec": "14",
	"Zap 200/1000 & 100 PWM": "15",
	"Zap 200/1000 & 150 PWM": "16",
	"Zap 200/1000 & 200 PWM": "17",
	"Zap 200/500 & 100 PWM": "18",
	"Zap 200/500 & 150 PWM": "19",
	"Zap 200/500 & 200 PWM": "20",
	'Zap 125/250 & no PWM': '21',
	'Zap 250/500 & no PWM': '22',
	'Zap 125/250 & 250 PWM': '23',
	'Zap 250/500 & 250 PWM': '24'
}

func arduino_messege( messege : String ) -> void:
	if ArduinoConnectionNode.arduinoConnected:
		ArduinoConnectionNode.SendToArduino(ArduinoData.arduinoEventLabel[messege])
	else:
		print(messege) 
	pass
