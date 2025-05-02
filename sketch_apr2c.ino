#include <Arduino.h>
#include <SoftwareSerial.h>

#define MOISTURE_PIN1 A0 // Analog pin for the moisture sensor
#define MOISTURE_PIN2 A1
#define MOISTURE_PIN3 A2
// Configure the software serial port for SIM800L
SoftwareSerial SIM800Serial(2, 3); // RX, TX

String apiKey = "WDCXZMJNCYL10ZPH"; // ThingSpeak API Key
String baseURL = "https://api.thingspeak.com/update?api_key="; // Base URL

void setup() {
  Serial.begin(9600);  // Start serial monitor
  SIM800Serial.begin(9600); // Start SIM800L module

  Serial.println("Initializing SIM800L...");

  // Check if SIM800L is responding
  SIM800Serial.println("AT");
  delay(2000);
  Serial.println("Sent: AT");

  // Set APN for Airtel (No username/password needed)
  SIM800Serial.println("AT+CSTT=\"airtelgprs.com\"");
  delay(5000);
  Serial.println("Sent: AT+CSTT=\"airtelgprs.com\"");

  // Start GPRS connection
  SIM800Serial.println("AT+CIICR");
  delay(5000);
  Serial.println("Sent: AT+CIICR (Waiting for GPRS)");

  // Get local IP address
  SIM800Serial.println("AT+CIFSR");
  delay(2000);
  Serial.println("Sent: AT+CIFSR (Getting IP)");

  // Set SIM800L to single connection mode
  SIM800Serial.println("AT+CIPMUX=0");
  delay(2000);
  Serial.println("Sent: AT+CIPMUX=0");
}

void loop() {
  // Read moisture sensor data
  int moistureValue1 = analogRead(MOISTURE_PIN1);
  int moistureValue2 = analogRead(MOISTURE_PIN2);
  int moistureValue3 = analogRead(MOISTURE_PIN3);

  // Convert raw value (0-1023) to percentage (0-100%)
  int moisturePercentage1 = map(moistureValue1, 800, 300, 0, 100);
  moisturePercentage1 = constrain(moisturePercentage1, 0, 100);  // Ensure within 0-100%

  int moisturePercentage2 = map(moistureValue2, 800, 300, 0, 100);
  moisturePercentage2 = constrain(moisturePercentage2, 0, 100);  // Ensure within 0-100%

  int moisturePercentage3 = map(moistureValue3, 800, 300, 0, 100);
  moisturePercentage3 = constrain(moisturePercentage3, 0, 100);  // Ensure within 0-100%

  Serial.print("Moisture Level-1: ");
  Serial.print(moisturePercentage1);
  Serial.println("%");

  Serial.print("Moisture Level-2: ");
  Serial.print(moisturePercentage2);
  Serial.println("%");

  Serial.print("Moisture Level-3: ");
  Serial.print(moisturePercentage3);
  Serial.println("%");

  // Construct the HTTP GET request
   String getRequest = "GET /update?api_key=" + apiKey + "&field1=" + String(moisturePercentage1)
                      + "&field2=" + String(moisturePercentage2)
                      + "&field3=" + String(moisturePercentage3);
  getRequest += " HTTP/1.1\r\n";
  getRequest += "Host: api.thingspeak.com\r\n";
  getRequest += "Connection: close\r\n\r\n";

  Serial.println("Connecting to ThingSpeak...");

  // Open TCP connection to ThingSpeak
  SIM800Serial.println("AT+CIPSTART=\"TCP\",\"api.thingspeak.com\",80");
  delay(5000);
  Serial.println("Sent: AT+CIPSTART (Connecting to ThingSpeak)");

  // Send HTTP GET request
  SIM800Serial.print("AT+CIPSEND=");
  SIM800Serial.println(getRequest.length());
  delay(2000);
  
  SIM800Serial.println(getRequest);
  delay(5000);

  Serial.println("Sent: GET request to ThingSpeak");

  // Close TCP connection
  SIM800Serial.println("AT+CIPCLOSE");
  delay(2000);
  Serial.println("Sent: AT+CIPCLOSE (Connection Closed)");

  Serial.println("Data sent to ThingSpeak!");

  // Delay for at least 15 seconds (ThingSpeak Free Limit)
  delay(15000);
}