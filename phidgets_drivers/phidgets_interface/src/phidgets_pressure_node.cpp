#include <ros/ros.h>
#include <phidgets_interface/Float32Stamped.h>
#include <phidgets_interface/Int16MultiArrayStamped.h>
#include <vector>
#include <iostream>

int Arr[8];
ros::Publisher press;
void chatterCallback(const phidgets_interface::Int16MultiArrayStamped::ConstPtr& msg)
{
  int i=0;
  for(std::vector<short int>::const_iterator it = msg->data.begin(); it != msg->data.end(); ++it)
  {
    Arr[i] = *it;
    i++;
  }
  phidgets_interface::Float32Stamped pressure;
  pressure.header = msg->header;
  pressure.data = (Arr[2]/9.2)+10.652;
  press.publish(pressure);
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "phidgets_pressure");
  ros::NodeHandle n;
  press = n.advertise<phidgets_interface::Float32Stamped>("/satellite/pressure",1000);
  ros::Subscriber sub = n.subscribe("phidgets/interface_kit/analog_input", 1000, chatterCallback);
  ros::spin();
  return 0;
}
