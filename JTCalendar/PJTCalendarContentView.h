//
//  JTCalendarContentView.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

@class PJTCalendar;

@interface PJTCalendarContentView : UIScrollView

@property (weak, nonatomic) PJTCalendar *calendarManager;

@property (nonatomic) NSDate *currentDate;

- (void)reloadData;
- (void)reloadAppearance;

@end
