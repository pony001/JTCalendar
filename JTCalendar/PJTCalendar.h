//
//  JTCalendar.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <UIKit/UIKit.h>

#import "PJTCalendarViewDataSource.h"
#import "PJTCalendarAppearance.h"

#import "PJTCalendarMenuView.h"
#import "PJTCalendarContentView.h"

#import "PJTCalendarDataCache.h"

@interface PJTCalendar : NSObject<UIScrollViewDelegate>

@property (weak, nonatomic) PJTCalendarMenuView *menuMonthsView;
@property (weak, nonatomic) PJTCalendarContentView *contentView;

@property (weak, nonatomic) id<PJTCalendarDataSource> dataSource;

@property (nonatomic) NSDate *currentDate;
@property (nonatomic) NSDate *currentDateSelected;

@property (nonatomic, readonly) PJTCalendarDataCache *dataCache;
@property (nonatomic, readonly) PJTCalendarAppearance *calendarAppearance;

- (void)reloadData;
- (void)reloadAppearance;

- (void)loadPreviousMonth DEPRECATED_MSG_ATTRIBUTE("Use loadPreviousPage instead");
- (void)loadNextMonth DEPRECATED_MSG_ATTRIBUTE("Use loadNextPage instead");

- (void)loadPreviousPage;
- (void)loadNextPage;

- (void)repositionViews;

@end
