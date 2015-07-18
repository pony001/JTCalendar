//
//  JTCalendarDataCache.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

@class PJTCalendar;

@interface PJTCalendarDataCache : NSObject

@property (weak, nonatomic) PJTCalendar *calendarManager;

- (float)targetPercentageForDate:(NSDate *)date;

@end
