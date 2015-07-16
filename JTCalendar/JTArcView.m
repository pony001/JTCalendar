//
//  JTArcView.m
//  Pods
//
//  Created by 马明晗 on 15/7/16.
//
//

#import "JTArcView.h"

@implementation JTArcView {
    CGFloat width;
}

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    self.backgroundColor = [UIColor clearColor];
    self.color = [UIColor colorWithRed:1 green:0.51 blue:0 alpha:1];//[UIColor whiteColor];
    self.bgColor = [UIColor colorWithRed:240./255 green:240./255 blue:240./255 alpha:1];
    self.anglePercent = 0;
    
    width = 2;
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [self.backgroundColor CGColor]);
    CGContextFillRect(ctx, rect);
    
    CGContextAddArc(ctx, rect.size.width/2, rect.size.height/2, rect.size.width/2 - width, -M_PI_2, -M_PI_2 + self.anglePercent*M_PI*2, 0);
    CGContextSetStrokeColorWithColor(ctx, [self.color CGColor]);
    CGContextSetLineWidth(ctx, width);
    CGContextStrokePath(ctx);
    
    CGContextAddArc(ctx, rect.size.width/2, rect.size.height/2, rect.size.width/2 - width, -M_PI_2 + self.anglePercent*M_PI*2, M_PI_2*3, 0);
    CGContextSetStrokeColorWithColor(ctx, [self.bgColor CGColor]);
    CGContextSetLineWidth(ctx, width);
    CGContextStrokePath(ctx);
}

- (void)setColor:(UIColor *)color
{
    self->_color = color;
    
    [self setNeedsDisplay];
}

@end
