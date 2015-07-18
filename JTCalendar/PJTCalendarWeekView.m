//
//  JTCalendarWeekView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "PJTCalendarWeekView.h"

#import "PJTCalendarDayView.h"

@interface PJTCalendarWeekView (){
    NSArray *daysViews;
};

@end

@implementation PJTCalendarWeekView

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
    NSMutableArray *views = [NSMutableArray new];
    
    for(int i = 0; i < 7; ++i){
        UIView *view = [PJTCalendarDayView new];
        
        [views addObject:view];
        [self addSubview:view];
    }
    
    daysViews = views;
}

- (void)layoutSubviews
{
    CGFloat monthViewLeft = self.calendarManager.calendarAppearance.monthViewLeft;
    CGFloat monthViewRight = self.calendarManager.calendarAppearance.monthViewRight;
    
    CGFloat x = monthViewLeft;
    CGFloat width = self.calendarManager.calendarAppearance.dayViewSize.width;//self.frame.size.width / 7.;
    CGFloat height = self.calendarManager.calendarAppearance.dayViewSize.height;
    CGFloat offset = (self.frame.size.width - monthViewLeft - monthViewRight - width * 7) / 6.;
    
    if(self.calendarManager.calendarAppearance.readFromRightToLeft){
        for(UIView *view in [[self.subviews reverseObjectEnumerator] allObjects]){
            view.frame = CGRectMake(x, 0, width, height);
            x = CGRectGetMaxX(view.frame);
            x = x + offset;
        }
    } else{
        for(UIView *view in self.subviews){
            view.frame = CGRectMake(x, 0, width, height);
            x = CGRectGetMaxX(view.frame);
            x = x + offset;
        }
    }
    
    [super layoutSubviews];
}

- (void)setBeginningOfWeek:(NSDate *)date
{
    NSDate *currentDate = date;
    
    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    
    for(PJTCalendarDayView *view in daysViews){
        if(!self.calendarManager.calendarAppearance.isWeekMode){
            NSDateComponents *comps = [calendar components:NSCalendarUnitMonth fromDate:currentDate];
            NSInteger monthIndex = comps.month;
                        
            [view setIsOtherMonth:monthIndex != self.currentMonthIndex];
        }
        else{
            [view setIsOtherMonth:NO];
        }
        
        [view setDate:currentDate];
        
        NSDateComponents *dayComponent = [NSDateComponents new];
        dayComponent.day = 1;
        
        currentDate = [calendar dateByAddingComponents:dayComponent toDate:currentDate options:0];
    }
}

#pragma mark - JTCalendarManager

- (void)setCalendarManager:(PJTCalendar *)calendarManager
{
    self->_calendarManager = calendarManager;
    for(PJTCalendarDayView *view in daysViews){
        [view setCalendarManager:calendarManager];
    }
}

- (void)reloadData
{
    for(PJTCalendarDayView *view in daysViews){
        [view reloadData];
    }
}

- (void)reloadAppearance
{
    for(PJTCalendarDayView *view in daysViews){
        [view reloadAppearance];
    }
}

@end
