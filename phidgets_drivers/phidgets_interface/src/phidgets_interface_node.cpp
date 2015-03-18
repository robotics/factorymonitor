#include "phidgets_interface/interface_ros_i.h"
#include <phidgets_interface/Int16MultiArrayStamped.h>
#include <phidgets_interface/SetOutputState.h>
Interface interface;
bool setOutputState(phidgets_interface::SetOutputState::Request  &req,
             phidgets_interface::SetOutputState::Response &res)
{
    res.ret = interface.setOutput(req.Index, req.State);
          return true;
}
int main(int argc, char **argv)
{
  ROS_INFO("Creating node: PhidgetsInterface");
  ros::init (argc, argv, "PhidgetsInterface");
  ros::NodeHandle nh;
  ros::Publisher input = nh.advertise<phidgets_interface::Int16MultiArrayStamped>("/phidgets/interface_kit/digital_input",1000);
  ros::Publisher output = nh.advertise<phidgets_interface::Int16MultiArrayStamped>("/phidgets/interface_kit/digital_output",1000);
  ros::Publisher sensor = nh.advertise<phidgets_interface::Int16MultiArrayStamped>("/phidgets/interface_kit/analog_input",1000);
  ros::ServiceServer service = nh.advertiseService("SetOutputState", setOutputState);
  ROS_INFO("Service Advertised");
  ros::Rate loop_rate(100);

  interface.open();
  interface.SetRatiometric(1);
  interface.ModifyAllTriggers(1);
  while(ros::ok()){
    phidgets_interface::Int16MultiArrayStamped input_msg;
    phidgets_interface::Int16MultiArrayStamped output_msg;
    phidgets_interface::Int16MultiArrayStamped sensor_msg;
    ros::Time timer = ros::Time::now();
    input_msg.header.stamp.sec = timer.sec;
    input_msg.header.stamp.nsec = timer.nsec;
    output_msg.header = input_msg.header;
    sensor_msg.header = input_msg.header;
    for (int i=0;i<interface.numInputs;i++) input_msg.data.push_back((short)Input[i]);
    for (int i=0;i<interface.numOutputs;i++) output_msg.data.push_back((short)Output[i]);
    for (int i=0;i<interface.numSensors;i++) sensor_msg.data.push_back((short)Sensor[i]);
    input.publish(input_msg);
    output.publish(output_msg);
    sensor.publish(sensor_msg);
    ros::spinOnce();
    loop_rate.sleep();
  }
  interface.close();
  return 0;
}
