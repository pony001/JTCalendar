//
//  JTCalendarMonthView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "PJTCalendar.h"

@interface PJTCalendarMonthView : UIView

@property (weak, nonatomic) PJTCalendar *calendarManager;

- (void)setBeginningOfMonth:(NSDate *)date;
- (void)reloadData;
- (void)reloadAppearance;

@end
