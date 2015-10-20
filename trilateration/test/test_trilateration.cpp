//
//  Trilateration.cpp
//
//  Created by waynewang on 17/5/14.
//  Copyright (c) 2014 waynewang. All rights reserved.
//
#include <gtest/gtest.h>
#include <trilateration/position.h>
#include <trilateration/trilateration.h>
// Consider an epsilon as below.
const double EPSILON = 1e-6;

TEST(TrilaterationTest,Test3PositionHasExactSolution)
{
    // workers and beacons
    Trilateration worker;
    PosAndDistance2dVec beacons;
    Pos2d location;
    
    beacons.push_back(PosAndDistance2d(Pos2d(0, 0), 1));
    beacons.push_back(PosAndDistance2d(Pos2d(1, 1), 1));
    beacons.push_back(PosAndDistance2d(Pos2d(2, 0), 1));
    
    worker.CalculateLocation2d(beacons, location);

    // Expected location (1, 0)
    EXPECT_TRUE(std::fabs(location[0] - 1) < EPSILON);
    EXPECT_TRUE(std::fabs(location[1]) < EPSILON);
}

TEST(TrilaterationTest,Test3PositionHasApporxSolution)
{
    // workers and beacons
    Trilateration worker;
    PosAndDistance2dVec beacons;
    Pos2d location;
    
    beacons.push_back(PosAndDistance2d(Pos2d(0, 0), 1));
    beacons.push_back(PosAndDistance2d(Pos2d(1, 1), 2));
    beacons.push_back(PosAndDistance2d(Pos2d(2, 0), 1));
    
    worker.CalculateLocation2d(beacons, location);

    // Expected location (1, -1.5)
    EXPECT_TRUE(std::fabs(location[0] - 1) < EPSILON);
    EXPECT_TRUE(std::fabs(location[1] - -1.5) < EPSILON);
}

TEST(TrilaterationTest,Test4PositionHasExactSolution)
{
    // workers and beacons
    Trilateration worker;
    PosAndDistance2dVec beacons;
    Pos2d location;
    
    beacons.push_back(PosAndDistance2d(Pos2d(0, 0), 1));
    beacons.push_back(PosAndDistance2d(Pos2d(1, 1), 1));
    beacons.push_back(PosAndDistance2d(Pos2d(2, 0), 1));
    beacons.push_back(PosAndDistance2d(Pos2d(1, -1), 1));
    
    worker.CalculateLocation2d(beacons, location);

    // Expected location (1, 0)
    EXPECT_TRUE(std::fabs(location[0] - 1) < EPSILON);
    EXPECT_TRUE(std::fabs(location[1]) < EPSILON);
}

TEST(TrilaterationTest,Test4PositionHasApporxSolution)
{
    // workers and beacons
    Trilateration worker;
    PosAndDistance2dVec beacons;
    Pos2d location;
    
    beacons.push_back(PosAndDistance2d(Pos2d(0, 0), 1));
    beacons.push_back(PosAndDistance2d(Pos2d(1, 1), 1.5));
    beacons.push_back(PosAndDistance2d(Pos2d(2, 0), 1));
    beacons.push_back(PosAndDistance2d(Pos2d(1, -1), 1.5));
    
    worker.CalculateLocation2d(beacons, location);
    
    // Expected location (1, 0)
    EXPECT_TRUE(std::fabs(location[0] - 1) < EPSILON);
    EXPECT_TRUE(std::fabs(location[1]) < EPSILON);
}

///////////////////////////////////////////////////////////////////////////////

// the main function
int main(int argc, char **argv){
    testing::InitGoogleTest(&argc, argv);
      return RUN_ALL_TESTS();
}
