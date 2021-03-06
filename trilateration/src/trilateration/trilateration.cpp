//
//  Trilateration.cpp
//
//  Created by waynewang on 19/4/14.
//  Copyright (c) 2014 waynewang. All rights reserved.
//
#include <trilateration/position.h>
#include <trilateration/trilateration.h>
#include <Eigen/Dense>
#include <math.h>

bool Trilateration::CalculateLocation2d(const PosAndDistance2dVec& beacons, Pos2d& location)
{
    // To locate position on a 2d plan, have to get at least 3 becaons,
    // otherwise return false.
    if (beacons.size() < 3)
        return false;
    
    // Define the matrix that we are going to use
    size_t count = beacons.size();
    size_t rows = count * (count - 1) / 2;
    Eigen::MatrixXd m(rows, 2);
    Eigen::VectorXd b(rows);
    
    // Fill in matrix according to the equations
    size_t row = 0;
    double x1, x2, y1, y2, r1, r2;
    PosAndDistance2d beacon1, beacon2;
    for (size_t i=0; i<count; ++i) {
        beacon1 = beacons[i];
        for (size_t j=i+1; j<count; ++j) {
            beacon2 = beacons[j];
            
            x1 = beacon1.m_pos(0), y1 = beacon1.m_pos(1);
            x2 = beacon2.m_pos(0), y2 = beacon2.m_pos(1);
            r1 = beacon1.m_distance;
            r2 = beacon2.m_distance;
            m(row, 0) = x1 - x2;
            m(row, 1) = y1 - y2;
            b(row) = ((pow(x1, 2)-pow(x2, 2)) +
                      (pow(y1, 2)-pow(y2, 2)) -
                      (pow(r1, 2) - pow(r2, 2))) / 2;
            row++;
        }
    }
    
    // Then calculate to solve the equations, using the least square solution
    location = m.jacobiSvd(Eigen::ComputeThinU|Eigen::ComputeThinV).solve(b);
    
    return true;
}

bool Trilateration::CalculateLocation3d(const PosAndDistance3dVec &beacons, Pos3d &location)
{
    // To locate position in a 3D space, have to get at least 4 becaons,
    // otherwise return false.
    if (beacons.size() < 3)
        return false;
    
    // Define the matrix that we are going to use
    size_t count = beacons.size();
    size_t rows = count * (count - 1) / 2;
    Eigen::MatrixXd m(rows, 3);
    Eigen::VectorXd b(rows);
    
    // Fill in matrix according to the equations
    size_t row = 0;
    double x1, x2, y1, y2, z1, z2, r1, r2;
    PosAndDistance3d beacon1, beacon2;
    for (size_t i=0; i<count; ++i) {
        beacon1 = beacons[i];
        for (size_t j=i+1; j<count; ++j) {
            beacon2 = beacons[j];
            
            x1 = beacon1.m_pos(0), y1 = beacon1.m_pos(1), z1 = beacon1.m_pos(2);
            x2 = beacon2.m_pos(0), y2 = beacon2.m_pos(1), z2 = beacon2.m_pos(2);
            r1 = beacon1.m_distance;
            r2 = beacon2.m_distance;
            m(row, 0) = x1 - x2;
            m(row, 1) = y1 - y2;
            m(row, 2) = z1 - z2;
            b(row) = ((pow(x1, 2)-pow(x2, 2)) +
                      (pow(y1, 2)-pow(y2, 2)) +
                      (pow(z1, 2)-pow(z2, 2)) -
                      (pow(r1, 2) - pow(r2, 2))) / 2;
            row++;
        }
    }
    
    // Then calculate to solve the equations, using the least square solution
    location = m.jacobiSvd(Eigen::ComputeThinU|Eigen::ComputeThinV).solve(b);
    
    return true;
}
