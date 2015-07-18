//
//  JTCalendarMonthWeekDaysView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "PJTCalendar.h"

@interface PJTCalendarMonthWeekDaysView : UIView

@property (weak, nonatomic) PJTCalendar *calendarManager;

+ (void)beforeReloadAppearance;
- (void)reloadAppearance;

@end
