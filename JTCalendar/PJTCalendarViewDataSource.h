//
//  JTCalendarDataSource.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class PJTCalendar;

@protocol PJTCalendarDataSource <NSObject>

- (float)calendar:(PJTCalendar *)calendar targetPercentageForDate:(NSDate *)date;
- (void)calendarDidDateSelected:(PJTCalendar *)calendar date:(NSDate *)date;

@optional

- (BOOL)calendar:(PJTCalendar *)calendar canSelectDate:(NSDate *)date;

- (void)calendarDidLoadPreviousPage;
- (void)calendarDidLoadNextPage;

@end
