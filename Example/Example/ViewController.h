//
//  ViewController.h
//  Example
//
//  Created by Jonathan Tribouharet.
//

#import <UIKit/UIKit.h>

#import "PJTCalendar.h"

@interface ViewController : UIViewController<PJTCalendarDataSource>

@property (weak, nonatomic) IBOutlet PJTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet PJTCalendarContentView *calendarContentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;

@property (strong, nonatomic) PJTCalendar *calendar;

@end
