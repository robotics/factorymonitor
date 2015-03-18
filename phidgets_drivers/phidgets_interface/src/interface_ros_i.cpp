#include "phidgets_interface/interface_ros_i.h"

int Sensor[8];
int Output[8];
int Input[8];
void Interface::open(){
  ifKit = 0;
  int result;
  const char *err;
  ROS_INFO("Creating Interface Kit instance");
  CPhidgetInterfaceKit_create(&ifKit);
  //Attach, Detach, OnError Handlers:
  CPhidget_set_OnAttach_Handler((CPhidgetHandle)ifKit, Interface::AttachHandler, NULL);
  CPhidget_set_OnDetach_Handler((CPhidgetHandle)ifKit, Interface::DetachHandler, NULL);
  CPhidget_set_OnError_Handler((CPhidgetHandle)ifKit, Interface::ErrorHandler, NULL);
  //IO change Handlers:
  CPhidgetInterfaceKit_set_OnInputChange_Handler (ifKit, Interface::InputChangeHandler, NULL);
  CPhidgetInterfaceKit_set_OnSensorChange_Handler (ifKit, Interface::SensorChangeHandler, NULL);
  CPhidgetInterfaceKit_set_OnOutputChange_Handler (ifKit, Interface::OutputChangeHandler, NULL);
  CPhidget_open((CPhidgetHandle)ifKit, -1);
  ROS_INFO("Waiting for interface kit to be attached...");
  if((result = CPhidget_waitForAttachment((CPhidgetHandle)ifKit, 10000))){
    CPhidget_getErrorDescription(result, &err);
    ROS_ERROR("Problem waiting for attachment: %s", err);
  }
  GetProperties();
  DisplayProperties();
}

void Interface::close(){
}

int CCONV Interface::AttachHandler(CPhidgetHandle IFK, void *userptr){
  int serialNo;
  const char *name;
  CPhidget_getDeviceName(IFK, &name);
  CPhidget_getSerialNumber(IFK, &serialNo);
  
  ROS_INFO("%s (%10d) attached!",name,serialNo);
  return 0;
}
int CCONV Interface::DetachHandler(CPhidgetHandle IFK, void *userptr){
  int serialNo;
  const char *name;
  CPhidget_getDeviceName(IFK, &name);
  CPhidget_getSerialNumber(IFK, &serialNo);
  
  ROS_INFO("%s (%10d) detached!",name,serialNo);
  return 0;
}
int CCONV Interface::ErrorHandler(CPhidgetHandle IFK, void *userptr, int ErrorCode, const char *unknown){
  ROS_ERROR("Error Handled. %d - %s", ErrorCode, unknown);
  return 0;
}
int CCONV Interface::InputChangeHandler(CPhidgetInterfaceKitHandle IFK, void *usrptr, int Index, int Value){
  ::Input[Index] = Value;
  return 0;
}
int CCONV Interface::OutputChangeHandler(CPhidgetInterfaceKitHandle IFK, void *usrptr, int Index, int Value)
{
  ::Output[Index] = Value;
	return 0;
}
int CCONV Interface::SensorChangeHandler(CPhidgetInterfaceKitHandle IFK, void *usrptr, int Index, int Value)
{
  ::Sensor[Index] = Value;
	return 0;
}

int Interface::GetProperties(){
  
	CPhidget_getDeviceType((CPhidgetHandle)ifKit, &deviceType);
	CPhidget_getSerialNumber((CPhidgetHandle)ifKit, &serialNo);
	CPhidget_getDeviceVersion((CPhidgetHandle)ifKit, &version);

	CPhidgetInterfaceKit_getInputCount(ifKit, &numInputs);
	CPhidgetInterfaceKit_getOutputCount(ifKit, &numOutputs);
	CPhidgetInterfaceKit_getSensorCount(ifKit, &numSensors);
	CPhidgetInterfaceKit_getRatiometric(ifKit, &ratiometric);
  return 0;
}
int Interface::DisplayProperties(){
	ROS_INFO("%s", deviceType);
	ROS_INFO("Serial Number: %10d Version: %8d", serialNo, version);
	ROS_INFO("# Digital Inputs: %d", numInputs);
  ROS_INFO("# Digital Outputs: %d", numOutputs);
	ROS_INFO("# Sensors: %d", numSensors);
	ROS_INFO("Ratiometric: %d", ratiometric);

	for(i = 0; i < numSensors; i++)
	{
		CPhidgetInterfaceKit_getSensorChangeTrigger (ifKit, i, &triggerVal);

		ROS_INFO("Sensor#: %d > Sensitivity Trigger: %d", i, triggerVal);
	}

	return 0;
}
int Interface::SetRatiometric(int Val){
  CPhidgetInterfaceKit_setRatiometric(ifKit, Val);
  ros::Duration(0.1).sleep();
  GetProperties();
  return 0;
}
int Interface::ModifyTrigger(int Sensor, int Trigger){
  CPhidgetInterfaceKit_setSensorChangeTrigger(ifKit, Sensor, Trigger);
}
int Interface::ModifyAllTriggers(int Trigger){
  for (int i = 0;i<numSensors;i++)
    ModifyTrigger(i,Trigger);
  return 0;
}
int Interface::setOutput(int Index, int State){
  CPhidgetInterfaceKit_setOutputState(ifKit, Index, State);
  return 1;
}
