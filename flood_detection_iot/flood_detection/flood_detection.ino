#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>

const char* ssid = "Kost Azio 3";
const char* password = "1234512345";

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

#define DATABASE_URL = "flooddetectioniot-default-rtdb.asia-southeast1.firebasedatabase.app";
#define API_KEY = "0C90nY5jNRV4kGRhx3jCyzxBABU7q03gvjcd1uQ6";

String sensorData;

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");

  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;

  Firebase.begin(DATABASE_URL, API_KEY);
  // Firebase.reconnectWiFi(true);
}

void loop() {
  if (Firebase.ready()) {
    Serial.println("Firebase is ready!")
  }
}