#ifndef PHIDGETS_INTERFACE_ROS_I_H
#define PHIDGETS_INTERFACE_ROS_I_H

#include <ros/ros.h>
#include <iostream>
#include <phidgets_api/phidget21.h>


class Interface{
  private:
    CPhidgetInterfaceKitHandle ifKit;
    const char* deviceType;
  public:
    void open();
    int serialNo, version, numInputs, numOutputs, numSensors, triggerVal, ratiometric, i;

    static int CCONV AttachHandler(CPhidgetHandle IFK, void *userptr);
    static int CCONV DetachHandler(CPhidgetHandle IFK, void *userptr);
    static int CCONV ErrorHandler(CPhidgetHandle IFK, void *userptr, int ErrorCode, const char *unknown);
    static int CCONV InputChangeHandler(CPhidgetInterfaceKitHandle IFK, void *userptr, int Index, int Value);
    static int CCONV OutputChangeHandler(CPhidgetInterfaceKitHandle IFK, void *userptr, int Index, int Value);
    static int CCONV SensorChangeHandler(CPhidgetInterfaceKitHandle IFK, void *userptr, int Index, int Value);
    int GetProperties();
    int DisplayProperties();
    int SetRatiometric(int Val);
    int setOutput(int Index, int State);
    int ModifyTrigger(int Sensor, int Trigger);
    int ModifyAllTriggers(int Trigger);
    void close();
};

extern int Output[8];
extern int Sensor[8];
extern int Input[8];
#endif
