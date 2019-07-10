#include "ros/ros.h"
#include "ros/console.h"

#include "pointmatcher/PointMatcher.h"
#include "pointmatcher/Timer.h"
#include "pointmatcher_ros/point_cloud.h"
#include "pointmatcher_ros/transform.h"
#include "nabo/nabo.h"
#include "eigen_conversions/eigen_msg.h"
#include "pointmatcher_ros/get_params_from_server.h"

#include <tf/transform_broadcaster.h>

#include <fstream>
#include <vector>
#include <algorithm>

#include <visualization_msgs/Marker.h>
#include <geometry_msgs/PoseStamped.h>
#include <nav_msgs/Path.h>

#include <numeric>

using namespace std;
using namespace PointMatcherSupport;

class selectByObserver
{
    typedef PointMatcher<float> PM;
    typedef PM::DataPoints DP;

public:
    selectByObserver(ros::NodeHandle &n);
    ~selectByObserver();
    ros::NodeHandle& n;

    string loadMapName;
    string saveMapName;

    int observeThreshold;

    bool isSave;

};

selectByObserver::~selectByObserver()
{}

selectByObserver::selectByObserver(ros::NodeHandle& n):
    n(n),
    loadMapName(getParam<string>("loadMapName", ".")),
    observeThreshold(getParam<int>("observeThreshold", 0)),
    saveMapName(getParam<string>("saveMapName", ".")),
    isSave(getParam<bool>("isSave",true))
{
    DP mapCloud  = DP::load(loadMapName);

    // process
    DP saveCloud = mapCloud.createSimilarEmpty();
    int cnt = 0;
    int rowLine_observeCnt = mapCloud.getDescriptorStartingRow("");
    for(int i=0; i<mapCloud.features.cols(); i++)
    {
        if(mapCloud.descriptors(rowLine_observeCnt, i) > observeThreshold)
        {
            saveCloud.setColFrom(cnt, mapCloud, i);
            cnt++;
        }
    }
    saveCloud.conservativeResize(cnt);

    cout<<"Filter Ratio:    "<<(double)(cnt / mapCloud.features.cols())<<endl;

    if(isSave)
        saveCloud.save(saveMapName);

}

int main(int argc, char **argv)
{

    ros::init(argc, argv, "selectByObserver");
    ros::NodeHandle n;

    selectByObserver selectByObserver(n);

    // ugly code

    return 0;
}
