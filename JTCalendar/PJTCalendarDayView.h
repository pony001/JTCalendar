//
//  JTCalendarDayView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "PJTCalendar.h"

@interface PJTCalendarDayView : UIView

@property (weak, nonatomic) PJTCalendar *calendarManager;

@property (nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL isOtherMonth;

- (void)reloadData;
- (void)reloadAppearance;

@end
