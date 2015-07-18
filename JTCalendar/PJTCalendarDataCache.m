//
//  JTCalendarDataCache.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "PJTCalendarDataCache.h"

#import "PJTCalendar.h"

@interface PJTCalendarDataCache(){};

@end

@implementation PJTCalendarDataCache

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    return self;
}

- (float)targetPercentageForDate:(NSDate *)date
{
    if(!self.calendarManager.dataSource){
        return 0;
    }
    
    if(!self.calendarManager.calendarAppearance.useCacheSystem){
        return [self.calendarManager.dataSource calendar:self.calendarManager targetPercentageForDate:date];
    }
    
    return 0;
}

@end