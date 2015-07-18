//
//  ViewController.m
//  Example
//
//  Created by Jonathan Tribouharet.
//

#import "ViewController.h"

@interface ViewController (){
    NSMutableDictionary *eventsByDate;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.calendar = [PJTCalendar new];
    
    // All modifications on calendarAppearance have to be done before setMenuMonthsView and setContentView
    // Or you will have to call reloadAppearance
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 7. / 10.;
        self.calendar.calendarAppearance.dayCircleColorSelected = [UIColor colorWithRed:1 green:0.51 blue:0 alpha:1];
        self.calendar.calendarAppearance.dayTextColorToday = [UIColor colorWithRed:1 green:0.51 blue:0 alpha:1];
        self.calendar.calendarAppearance.dayCircleColorToday = [UIColor clearColor];
        
        self.calendar.calendarAppearance.ratioContentMenu = 2.;
        self.calendar.calendarAppearance.focusSelectedDayChangeMode = YES;
        
        self.calendar.calendarAppearance.dayDotRatio = 1;
        self.calendar.calendarAppearance.dayDotColor = [UIColor colorWithRed:1 green:0.51 blue:0 alpha:1];
        self.calendar.calendarAppearance.dayDotColorSelected = [UIColor colorWithRed:1 green:0.51 blue:0 alpha:1];
        self.calendar.calendarAppearance.dayDotColorToday = [UIColor colorWithRed:1 green:0.51 blue:0 alpha:1];
        self.calendar.calendarAppearance.useCacheSystem = NO;
        
        self.calendar.calendarAppearance.monthViewLeft = 12;
        self.calendar.calendarAppearance.monthViewRight = 12;
        self.calendar.calendarAppearance.showOtherMonth = NO;
        // Customize the text for each month
        self.calendar.calendarAppearance.monthBlock = ^NSString *(NSDate *date, PJTCalendar *jt_calendar){
            NSCalendar *calendar = jt_calendar.calendarAppearance.calendar;
            NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
            NSInteger currentMonthIndex = comps.month;
            
            static NSDateFormatter *dateFormatter;
            if(!dateFormatter){
                dateFormatter = [NSDateFormatter new];
                dateFormatter.timeZone = jt_calendar.calendarAppearance.calendar.timeZone;
            }
            
            while(currentMonthIndex <= 0){
                currentMonthIndex += 12;
            }
            
            NSString *monthText = [[dateFormatter standaloneMonthSymbols][currentMonthIndex - 1] capitalizedString];
            
            return [NSString stringWithFormat:@"%ld\n%@", comps.year, monthText];
        };
    }
    
    {
        self.calendar.calendarAppearance.isWeekMode = YES;
        self.calendar.calendarAppearance.showWeekdaysView = NO;
        self.calendarContentViewHeight.constant = 34.;
    }
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    
    [self createRandomEvents];
    
    [self.calendar reloadData];
}

- (void)viewDidLayoutSubviews
{
    [self.calendar repositionViews];
}

#pragma mark - Buttons callback

- (IBAction)didGoTodayTouch
{
    [self.calendar setCurrentDate:[NSDate date]];
}

- (IBAction)didChangeModeTouch
{
    self.calendar.calendarAppearance.isWeekMode = !self.calendar.calendarAppearance.isWeekMode;
    
    if(self.calendar.calendarAppearance.isWeekMode){
        self.calendar.calendarAppearance.showWeekdaysView = NO;
    } else {
        self.calendar.calendarAppearance.showWeekdaysView = YES;
    }
    
    [self transitionExample];
}

#pragma mark - JTCalendarDataSource

- (float)calendar:(PJTCalendar *)calendar targetPercentageForDate:(NSDate *)date
{
    return arc4random()*1./UINT32_MAX;
}

- (void)calendarDidDateSelected:(PJTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    NSArray *events = eventsByDate[key];
    
    NSLog(@"Date: %@ - %ld events", date, [events count]);
}

- (void)calendarDidLoadPreviousPage
{
    NSLog(@"Previous page loaded");
    
}

- (void)calendarDidLoadNextPage
{
    NSLog(@"Next page loaded");
//    [self.calendar setCurrentDateSelected:[NSDate date]];
//    [self.calendar reloadAppearance];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"kJTCalendarDaySelected" object:[NSDate date]];
//    
}

#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 420;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 34.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}

#pragma mark - Fake data

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (void)createRandomEvents
{
    eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
             
        [eventsByDate[key] addObject:randomDate];
    }
}

@end
