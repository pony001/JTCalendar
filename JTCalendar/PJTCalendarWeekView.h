//
//  JTCalendarWeekView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "PJTCalendar.h"

@interface PJTCalendarWeekView : UIView

@property (weak, nonatomic) PJTCalendar *calendarManager;

@property (assign, nonatomic) NSUInteger currentMonthIndex;

- (void)setBeginningOfWeek:(NSDate *)date;
- (void)reloadData;
- (void)reloadAppearance;

@end
