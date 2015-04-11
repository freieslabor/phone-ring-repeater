// sound sensor connected to analog pin 0
const int SENSOR = A0;
// piezo connected to digital pin 9
const int PIEZO = 9;

// sensor sum over time
long sensorSum = 0;
// current sensor value
int sensorValue = 0;
// times the sensor has been read
int count = 0;

void setup() {
  // 
  pinMode(PIEZO, OUTPUT);
}

void loop() {
  sensorValue = analogRead(SENSOR);
  // prefilter noise
  if (sensorValue > 100) sensorSum += sensorValue;
  count += 1;
  
  if (count > 10000) {
    // high volume during this timespan seems to be phone ringing
    if (sensorSum > 100000) {
      beep(50);
      beep(50);
      beep(50);
    }
    sensorSum = 0;
    count = 0;
  }
}

void beep(unsigned char delayms){
  // tone frequency
  analogWrite(PIEZO, 200);
  delay(delayms);
  // turn it off
  analogWrite(PIEZO, 0);
  delay(delayms);
}
