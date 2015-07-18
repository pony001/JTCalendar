//
//  JTCalendarMenuView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

@class PJTCalendar;

@interface PJTCalendarMenuView : UIScrollView

@property (weak, nonatomic) PJTCalendar *calendarManager;

@property (nonatomic) NSDate *currentDate;

- (void)reloadAppearance;

@end
