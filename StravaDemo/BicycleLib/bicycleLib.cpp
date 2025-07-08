//
//  bicycleLib.h
//  StravaDemo
//
//  Created by Jason on 6/23/25.
//

#include "bicyclelib.h"

int BicycleLib::revolutions(double distance, double tireCircumference) {
    return (int)(distance / tireCircumference);
}
