#include <ros/ros.h>
#include <phidgets_interface/Float32Stamped.h>
#include <phidgets_interface/Int16MultiArrayStamped.h>
#include <vector>
#include <iostream>

int Arr[8];
ros::Publisher humid;
void chatterCallback(const phidgets_interface::Int16MultiArrayStamped::ConstPtr& msg)
{
  int i=0;
  for(std::vector<short int>::const_iterator it = msg->data.begin(); it != msg->data.end(); ++it)
  {
    Arr[i] = *it;
    i++;
  }
  phidgets_interface::Float32Stamped humidity;
  humidity.header = msg->header;
  humidity.data = Arr[3]*0.1906-40.2;
  humid.publish(humidity);
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "phidgets_humidity");
  ros::NodeHandle n;
  humid = n.advertise<phidgets_interface::Float32Stamped>("/satellite/humidity",1000);
  ros::Subscriber sub = n.subscribe("phidgets/interface_kit/analog_input", 1000, chatterCallback);
  ros::spin();
  return 0;
}
