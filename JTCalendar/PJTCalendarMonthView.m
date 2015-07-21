//
//  JTCalendarMonthView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "PJTCalendarMonthView.h"

#import "PJTCalendarMonthWeekDaysView.h"
#import "PJTCalendarWeekView.h"

#define WEEKS_TO_DISPLAY 6

@interface PJTCalendarMonthView () {
  PJTCalendarMonthWeekDaysView *weekdaysView;
  NSArray *weeksViews;

  NSUInteger currentMonthIndex;
  BOOL cacheLastWeekMode; // Avoid some operations
};

@end

@implementation PJTCalendarMonthView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (!self) {
    return nil;
  }

  [self commonInit];

  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (!self) {
    return nil;
  }

  [self commonInit];

  return self;
}

- (void)commonInit {
  NSMutableArray *views = [NSMutableArray new];

  {
    weekdaysView = [PJTCalendarMonthWeekDaysView new];
    [self addSubview:weekdaysView];
  }

  for (int i = 0; i < WEEKS_TO_DISPLAY; ++i) {
    UIView *view = [PJTCalendarWeekView new];

    [views addObject:view];
    [self addSubview:view];
  }

  weeksViews = views;

  cacheLastWeekMode = self.calendarManager.calendarAppearance.isWeekMode;
}

- (void)layoutSubviews {
  [self configureConstraintsForSubviews];

  [super layoutSubviews];
}

- (void)configureConstraintsForSubviews {
  CGFloat weeksToDisplay;

  if (cacheLastWeekMode) {
    weeksToDisplay = 1.;
  } else {
    weeksToDisplay = (CGFloat)(WEEKS_TO_DISPLAY);
  }

  if (self.calendarManager.calendarAppearance.showWeekdaysView) {
    weeksToDisplay = weeksToDisplay + 1;
  }

  CGFloat y = 0;
  CGFloat width = self.frame.size.width;
  CGFloat height = self.calendarManager.calendarAppearance.dayViewSize
                       .height; // self.frame.size.height / weeksToDisplay;

  if (weeksToDisplay == 1) {
  }
  CGFloat offset = 0;
  if (weeksToDisplay > 1) {
    offset = (self.frame.size.height - height * weeksToDisplay) /
             (weeksToDisplay - 1);
  }

  for (int i = 0; i < self.subviews.count; ++i) {
    UIView *view = self.subviews[i];
    if (i == 0 && !self.calendarManager.calendarAppearance.showWeekdaysView) {
      view.frame = CGRectMake(0, y, width, 0);
      view.hidden = YES;
      continue;
    }

    if ((int)height == 0) {
      view.hidden = YES;
    } else {
      view.hidden = NO;
    }

    view.frame = CGRectMake(0, y, width, height);
    y = CGRectGetMaxY(view.frame);
    y = y + offset;

    if (self.calendarManager.calendarAppearance.showWeekdaysView) {
      if (cacheLastWeekMode && i == weeksToDisplay - 1) {
        height = 0.;
        offset = 0.;
      }
    } else {
      if (cacheLastWeekMode && i == weeksToDisplay) {
        height = 0.;
        offset = 0.;
      }
    }
  }
}

- (void)setBeginningOfMonth:(NSDate *)date {
  NSDate *currentDate = date;

  NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;

  {
    NSDateComponents *comps =
        [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay
                    fromDate:currentDate];

    currentMonthIndex = comps.month;

    // Hack
    if (comps.day > 7) {
      currentMonthIndex = (currentMonthIndex % 12) + 1;
    }
  }

  for (PJTCalendarWeekView *view in weeksViews) {
    view.currentMonthIndex = currentMonthIndex;
    [view setBeginningOfWeek:currentDate];

    NSDateComponents *dayComponent = [NSDateComponents new];
    dayComponent.day = 7;

    currentDate = [calendar dateByAddingComponents:dayComponent
                                            toDate:currentDate
                                           options:0];

    // Doesn't need to do other weeks
    if (self.calendarManager.calendarAppearance.isWeekMode) {
      break;
    }
  }
}

#pragma mark - JTCalendarManager

- (void)setCalendarManager:(PJTCalendar *)calendarManager {
  self->_calendarManager = calendarManager;

  [weekdaysView setCalendarManager:calendarManager];
  for (PJTCalendarWeekView *view in weeksViews) {
    [view setCalendarManager:calendarManager];
  }
}

- (void)reloadData {
  for (PJTCalendarWeekView *view in weeksViews) {
    [view reloadData];

    // Doesn't need to do other weeks
    if (self.calendarManager.calendarAppearance.isWeekMode) {
      break;
    }
  }
}

- (void)reloadAppearance {
  if (cacheLastWeekMode != self.calendarManager.calendarAppearance.isWeekMode) {
    cacheLastWeekMode = self.calendarManager.calendarAppearance.isWeekMode;
    [self configureConstraintsForSubviews];
  }

  [PJTCalendarMonthWeekDaysView beforeReloadAppearance];
  [weekdaysView reloadAppearance];

  for (PJTCalendarWeekView *view in weeksViews) {
    [view reloadAppearance];
  }
}

@end
