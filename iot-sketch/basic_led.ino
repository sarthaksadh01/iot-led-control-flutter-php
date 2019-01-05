#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include<String>

const char* ssid = "sarthak";
const char* password = "sarthak01";
 
void setup () {
 
    pinMode(02, OUTPUT);
 
   Serial.begin(9600);
   WiFi.begin(ssid, password);
 
   while (WiFi.status() != WL_CONNECTED) 
   
   {
 
    delay(1000);
    Serial.print("Connecting..");
 
  }
 
}
 
void loop() {

 
  if (WiFi.status() == WL_CONNECTED) { //Check WiFi connection status
 
    HTTPClient http;  //Declare an object of class HTTPClient
 
    http.begin("your website.com");  //Specify request destination
    int httpCode = http.GET();                                                                  //Send the request
    if (httpCode > 0) { //Check the returning code
 
        String payload = http.getString(); 
        Serial.println("output is "+payload);
        int z = payload.toInt();

       analogWrite(02,z);
 
    }
 
    http.end();   //Close connection
 
  }
 
  delay(500);    //Send a request every 30 seconds
 
}
