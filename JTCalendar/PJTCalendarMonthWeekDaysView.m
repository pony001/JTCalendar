//
//  JTCalendarMonthWeekDaysView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "PJTCalendarMonthWeekDaysView.h"

@implementation PJTCalendarMonthWeekDaysView

static NSArray *cacheDaysOfWeeks;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{    
    for(NSString *day in [self daysOfWeek]){
        UILabel *view = [UILabel new];
        
        view.font = self.calendarManager.calendarAppearance.weekDayTextFont;
        view.textColor = self.calendarManager.calendarAppearance.weekDayTextColor;
        
        view.textAlignment = NSTextAlignmentCenter;
        view.text = day;
        
        [self addSubview:view];
    }
}

- (NSArray *)daysOfWeek
{
    if(cacheDaysOfWeeks){
        return cacheDaysOfWeeks;
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSMutableArray *days = nil;
    
    switch(self.calendarManager.calendarAppearance.weekDayFormat) {
        case JTCalendarWeekDayFormatSingle:
            days = [[dateFormatter veryShortStandaloneWeekdaySymbols] mutableCopy];
            break;
    case JTCalendarWeekDayFormatShort:
            days = [[dateFormatter shortStandaloneWeekdaySymbols] mutableCopy];
            break;
    case JTCalendarWeekDayFormatFull:
            days = [[dateFormatter standaloneWeekdaySymbols] mutableCopy];
            break;
    }
    
    for(NSInteger i = 0; i < days.count; ++i){
        NSString *day = days[i];
        [days replaceObjectAtIndex:i withObject:[day uppercaseString]];
    }
    
    // Redorder days for be conform to calendar
    {
        NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
        NSUInteger firstWeekday = (calendar.firstWeekday + 6) % 7; // Sunday == 1, Saturday == 7
        
        for(int i = 0; i < firstWeekday; ++i){
            id day = [days firstObject];
            [days removeObjectAtIndex:0];
            [days addObject:day];
        }
    }
    
    cacheDaysOfWeeks = days;
    return cacheDaysOfWeeks;
}

- (void)layoutSubviews
{
    CGFloat monthViewLeft = self.calendarManager.calendarAppearance.monthViewLeft;
    CGFloat monthViewRight = self.calendarManager.calendarAppearance.monthViewRight;
    
    CGFloat x = monthViewLeft;
    CGFloat width = self.calendarManager.calendarAppearance.dayViewSize.width;//self.frame.size.width / 7.;
    CGFloat height = self.frame.size.height;
    CGFloat offset = (self.frame.size.width - monthViewLeft - monthViewRight - width * 7) / 6.;
    
    if(self.calendarManager.calendarAppearance.readFromRightToLeft){
        for(UIView *view in [[self.subviews reverseObjectEnumerator] allObjects]){
            view.frame = CGRectMake(x, 0, width, height);
            x = CGRectGetMaxX(view.frame);
            x = x + offset;
        }
    }
    else{
        for(UIView *view in self.subviews){
            view.frame = CGRectMake(x, 0, width, height);
            x = CGRectGetMaxX(view.frame);
            x = x + offset;
        }
    }
    
    // No need to call [super layoutSubviews]
}

+ (void)beforeReloadAppearance
{
    cacheDaysOfWeeks = nil;
}

- (void)reloadAppearance
{
    for(int i = 0; i < self.subviews.count; ++i){
        UILabel *view = [self.subviews objectAtIndex:i];
        
        view.font = self.calendarManager.calendarAppearance.weekDayTextFont;
        view.textColor = self.calendarManager.calendarAppearance.weekDayTextColor;
        
        view.text = [[self daysOfWeek] objectAtIndex:i];
    }
}

@end
