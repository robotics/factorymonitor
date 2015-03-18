#include <ros/ros.h>
#include <phidgets_interface/Float32Stamped.h>
#include <phidgets_interface/Int16MultiArrayStamped.h>
#include <vector>
#include <iostream>

int Arr[8];
ros::Publisher temp;
void chatterCallback(const phidgets_interface::Int16MultiArrayStamped::ConstPtr& msg)
{
  int i=0;
  for(std::vector<short int>::const_iterator it = msg->data.begin(); it != msg->data.end(); ++it)
  {
    Arr[i] = *it;
    i++;
  }
  phidgets_interface::Float32Stamped temperature;
  temperature.header = msg->header;
  temperature.data = Arr[1]*0.22222 -61.11;
  temp.publish(temperature);
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "phidgets_temperature");
  ros::NodeHandle n;
  temp = n.advertise<phidgets_interface::Float32Stamped>("/satellite/temperature",1000);
  ros::Subscriber sub = n.subscribe("phidgets/interface_kit/analog_input", 1000, chatterCallback);
  ros::spin();
  return 0;
}
