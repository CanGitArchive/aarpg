using Godot;
using System;
using System.IO.Ports;

public partial class arduino_connection : Node
{
	
	private SerialPort serialPort;
	public bool arduinoConnected = false;  // Declare the boolean variable

	public override void _Ready()
	{
		serialPort = new SerialPort();
		serialPort.PortName = "COM3"; // Change if needed
		serialPort.BaudRate = 9600;
		
		//////////////////////////////////////////////////
		if(false)
		{
			try
			{
				serialPort.Open();
				GD.Print("Serial port opened.");
				arduinoConnected = true; 
			}
			catch (Exception e)
			{
				GD.PrintErr($"Failed to open serial port: {e.Message}");
				arduinoConnected = false;
			}
		}
		//////////////////////////////////////////////////
	}
	
	  public void SendToArduino(string message)
	{
		// Ensure the port is open before sending data.
		if (serialPort != null && serialPort.IsOpen)
		{
			try
			{
				GD.Print("Sending data to Arduino...");
				serialPort.Write("\n");    // Send newline (start)
				serialPort.Write(message);     // Send data
				serialPort.Write("\n");    // Send newline (end)
			}
			catch (Exception e)
			{
				GD.PrintErr($"Error writing to serial port: {e.Message}");
			}
		}
		else
		{
			GD.PrintErr("Serial port is not open.");
		}
	}

}
