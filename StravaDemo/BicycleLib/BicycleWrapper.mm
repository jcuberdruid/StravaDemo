//
//  bicycleLibWrapper.mm
//  StravaDemo
//
//  Created by Jason on 6/23/25.
//

#import "BicycleWrapper.h"
#import "bicyclelib.h"
@implementation BicycleWrapper

+ (int)revolutionsWithDistance:(double)distance tireCircumference:(double)circumference {
    return BicycleLib::revolutions(distance, circumference);
}
@end
