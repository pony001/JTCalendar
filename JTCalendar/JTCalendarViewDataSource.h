//
//  JTCalendarDataSource.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendar;

@protocol JTCalendarDataSource <NSObject>

- (float)calendar:(JTCalendar *)calendar targetPercentageForDate:(NSDate *)date;
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date;

@optional

- (BOOL)calendar:(JTCalendar *)calendar canSelectDate:(NSDate *)date;

- (void)calendarDidLoadPreviousPage;
- (void)calendarDidLoadNextPage;

@end
