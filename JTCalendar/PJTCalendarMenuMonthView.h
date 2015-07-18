//
//  JTCalendarMenuMonthView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "PJTCalendar.h"

@interface PJTCalendarMenuMonthView : UIView

@property (weak, nonatomic) PJTCalendar *calendarManager;

- (void)setCurrentDate:(NSDate *)currentDate;

- (void)reloadAppearance;

@end
