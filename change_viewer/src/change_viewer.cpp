#include <ros/ros.h>
#include <pcl_ros/point_cloud.h>
#include <pcl/point_types.h>
#include <pcl/octree/octree.h>
#include <vector>
#include <pcl/filters/voxel_grid.h>
#include <boost/foreach.hpp>
#include <ros/console.h>
#include <pcl/filters/extract_indices.h>
#include "std_msgs/Int64.h"

typedef pcl::PointCloud<pcl::PointXYZ> PointCloud;
float resolution = 1.0f;
pcl::octree::OctreePointCloudChangeDetector<pcl::PointXYZ> octree (resolution);
ros::Publisher pub;

void callback(const PointCloud::ConstPtr& msg)
{
  pcl::ExtractIndices<pcl::PointXYZ> extract;
  ROS_INFO("Cloud: width = %d, height = %d", msg->width, msg->height);
  octree.switchBuffers();
  octree.setInputCloud(msg);
  octree.addPointsFromInputCloud();
  std::vector<int> newPointIdxVector;
  octree.getPointIndicesFromNewVoxels(newPointIdxVector);
  ROS_INFO("Indices_changed = %lu", newPointIdxVector.size());
  std_msgs::Int64 msg_publish;
  msg_publish.data = newPointIdxVector.size();
  pub.publish(msg_publish);

}

int main(int argc, char** argv)
{
  ros::init(argc, argv, "change_viewer");
  ros::NodeHandle nh;
  ros::Subscriber sub = nh.subscribe<PointCloud>("/satellite1/sd/points", 1, callback);
  pub = nh.advertise<std_msgs::Int64>("commotion",10);
  ros::spin();
}
