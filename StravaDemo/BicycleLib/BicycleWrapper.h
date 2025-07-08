//
//  BicycleLibWrapper.h
//  StravaDemo
//
//  Created by Jason on 6/23/25.
//

#import <Foundation/Foundation.h>

@interface BicycleWrapper : NSObject
+ (int)revolutionsWithDistance:(double)distance tireCircumference:(double)circumference;
@end
