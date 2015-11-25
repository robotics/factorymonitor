#include "Wire.h"
#include "I2Cdev.h"
#include "BMP085.h"
#include "isl29023.h"
#include "SFE_BMP180.h"

// class default I2C address is 0x77
// specific I2C addresses may be passed as a parameter here
// (though the BMP085 supports only one address)
BMP085 barometer;
SFE_BMP180 pressure;
ISL29023 isl = ISL29023();
int32_t lastMicros;

//define OUTPUT_READABLE_QUATERNION
//#define OUTPUT_READABLE_EULER
//#define OUTPUT_READABLE_YAWPITCHROLL
//#define OUTPUT_READABLE_REALACCEL
//#define OUTPUT_READABLE_WORLDACCEL
//#define OUTPUT_TEAPOT
#define OUTPUT_BMP180
#define OUTPUT_ISL29023
#define OUTPUT_SHT21
volatile bool mpuInterrupt =true;     // indicates whether MPU interrupt pin has gone high
void dmpDataReady() {
  mpuInterrupt = true;
  //Serial.println("int");
}

#define LED_PIN BLUE_LED // (Arduino is 13, Teensy is 11, Teensy++ is 6)
bool blinkState = false;

void setup()
{
  // put your setup code here, to run once
  Wire.begin();
  Serial.begin(115200);
  //mpu.initialize();
  barometer.initialize();
  //Serial.println(F("Testing device connections..."));
  //Serial.println(barometer.testConnection() ? "BMP085 connection successful" : "BMP085 connection failed");
  isl.init();
  pressure.begin();
  pinMode(LED_PIN, OUTPUT);


}
void binaryPrint(byte * var,int size){
  for(int i=0;i<size;i++)
    Serial.write(var[i]);
}
double T,P, p0,a;
int modeBMP180=0;
int time_delay;
long nowP;
void getBMP180(){
  switch(modeBMP180){
    case 0://begin temp measurement
      time_delay=pressure.startTemperature();
      nowP = millis();
      modeBMP180++;
      break;
    case 1://complete temperature measurement
      if(millis()-nowP>time_delay){
        pressure.getTemperature(T);
        modeBMP180++;
      }
      break;
    case 2://begin humidity measurement
      time_delay = pressure.startPressure(3);
      nowP = millis();
      modeBMP180++;
      break;
    case 3:
      if(millis()-nowP>time_delay){
        pressure.getPressure(P,T);
        modeBMP180=0;
      }
    default:
      break;
  }

}


int modeSHT21=false;
long nowT;
int SHT21buffer=0;
char SHT21c[2];
int SHT21i=0;

float temperature_sht21;
float humidity_sht21;
void getSHT21(){
  switch(modeSHT21){
    case 0://begin temp measurement
      Wire.beginTransmission(0x40);
      Wire.write(0xF3);
      Wire.endTransmission();
      nowT = millis();
      modeSHT21++;
      break;
    case 1://complete temperature measurement
      if(millis()-nowT>85){
        SHT21i=0;
        Wire.requestFrom(0x40,2);
        while(Wire.available()){
          SHT21c[SHT21i++]=Wire.read();
          
        }
        SHT21buffer = ((int)SHT21c[0]<<8)+(int)SHT21c[1];
        temperature_sht21 = -46.85+175.72*(SHT21buffer)/65536;
        modeSHT21++;
      }
      break;
    case 2://begin humidity measurement
      Wire.beginTransmission(0x40);
      Wire.write(0xF5);
      Wire.endTransmission();
      nowT = millis();
      modeSHT21++;
      break;
    case 3:
      if(millis()-nowT>29){
        SHT21i=0;
        Wire.requestFrom(0x40,2);
        while(Wire.available())
          SHT21c[SHT21i++]=Wire.read();
        SHT21buffer = ((int)SHT21c[0]<<8)+((int)SHT21c[1]);
        humidity_sht21 = -6+125*(SHT21buffer)/65536;
        modeSHT21=0;
      }
    default:
      break;
  }
}

void getBMP1801(){
  switch(modeSHT21){
    case 0://begin temp measurement
      Wire.beginTransmission(0x40);
      Wire.write(0xF3);
      Wire.endTransmission();
      nowT = millis();
      modeSHT21++;
      break;
    case 1://complete temperature measurement
      if(millis()-nowT>85){
        SHT21i=0;
        Wire.requestFrom(0x40,2);
        while(Wire.available()){
          SHT21c[SHT21i++]=Wire.read();
          
        }
        SHT21buffer = ((int)SHT21c[0]<<8)+(int)SHT21c[1];
        temperature_sht21 = -46.85+175.72*(SHT21buffer)/65536;
        modeSHT21++;
      }
      break;
    case 2://begin humidity measurement
      Wire.beginTransmission(0x40);
      Wire.write(0xF5);
      Wire.endTransmission();
      nowT = millis();
      modeSHT21++;
      break;
    case 3:
      if(millis()-nowT>29){
        SHT21i=0;
        Wire.requestFrom(0x40,2);
        while(Wire.available())
          SHT21c[SHT21i++]=Wire.read();
        SHT21buffer = ((int)SHT21c[0]<<8)+((int)SHT21c[1]);
        humidity_sht21 = -6+125*(SHT21buffer)/65536;
        modeSHT21=0;
      }
    default:
      break;
  }
}
  
  
void loop()
{
  //If not started measuring, start measuring Temperature:
  
#ifdef OUTPUT_BMP180
    getBMP180();
    Serial.print("b ");
    Serial.print(T);
    Serial.print(" ");
    Serial.print(P);
    Serial.print(" ");
#endif
#ifdef OUTPUT_SHT21
    getSHT21();
    Serial.print("h ");
    Serial.print(temperature_sht21);
    Serial.print(" ");
    Serial.print(humidity_sht21);
    //float a = 1.0;
    //binaryPrint((byte *)&a,sizeof(a));
#endif
#ifdef OUTPUT_ISL29023
  Serial.print("l ");
  Serial.print(isl.read());
  Serial.print(" ");
#endif
    Serial.println();

    // blink LED to indicate activity
    blinkState = !blinkState;
    digitalWrite(LED_PIN, blinkState);

}
