//
//  ProgressCircleView.m
//  Sublime Art
//
//  Created by Ryan on 8/1/15.
//

#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)
#import "ProgressCircleView.h"

@interface ProgressCircleView () {
    CGFloat startAngle;
    CGFloat endAngle;
    UIView *overlayView;
    UILabel *percentLabel;
    UIBezierPath *bezierPath;
}

@end

@implementation ProgressCircleView

@synthesize progressColor;
@synthesize diameterRect;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor lightGrayColor];
        overlayView = [[UIView alloc] initWithFrame:CGRectMake(8, 8, frame.size.width-16, frame.size.height-16)];
        percentLabel = [[UILabel alloc]init];
        // Determine our start and stop angles for the arc (in radians)
        startAngle = M_PI * 1.5;
        endAngle = startAngle + (M_PI * 2);
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    rect = diameterRect;
    self.frame = rect;
    self.layer.cornerRadius = rect.size.width/2;
    
    //Overlay view
    overlayView.frame = CGRectMake(8, 8, rect.size.width-16, rect.size.height-16);
    overlayView.backgroundColor = [UIColor darkGrayColor];
    overlayView.layer.cornerRadius = overlayView.frame.size.width/2;
    [self addSubview:overlayView];
    
    // Display our percentage as a string
    NSNumber *number = [NSNumber numberWithFloat:roundf(_percent)];
    NSString* textContent = [NSString stringWithFormat:@"%@", number];
    textContent = [textContent stringByAppendingString:@"%"];

    percentLabel.adjustsFontSizeToFitWidth = YES;
    percentLabel.text = textContent;
    percentLabel.textColor = [UIColor whiteColor];
    CGSize textSize = [[percentLabel text] sizeWithAttributes:@{NSFontAttributeName:[percentLabel font]}];
    CGFloat percentLabelWidth = textSize.width;
    CGFloat percentLabelHeight = textSize.height;
    CGFloat percentLabelX = overlayView.frame.size.width/2 - percentLabelWidth/2;
    CGFloat percentLabelY = overlayView.frame.size.width/2 - percentLabelWidth/2;
    
    if (_percent <= 9.0) {
        percentLabel.frame = CGRectMake(percentLabelX, percentLabelY-4, percentLabelWidth, percentLabelHeight);
    }
    else{
        percentLabel.frame = CGRectMake(percentLabelX, percentLabelY, percentLabelWidth, percentLabelHeight);
    }
    
    //Create the progress path
    bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineCapStyle = kCGLineCapButt;
    CGFloat dashes[] = {4, 2};
    [bezierPath setLineDash:dashes count:2 phase:0];
    [bezierPath addArcWithCenter:CGPointMake( rect.size.width / 2, rect.size.height / 2)
                          radius:rect.size.width / 2
                      startAngle:startAngle
                        endAngle: (endAngle - startAngle) * (_percent / 100.0) + startAngle
                       clockwise:YES];
    
    // Set the display for the path
    bezierPath.lineWidth = 16;
    [progressColor setStroke];
    [bezierPath stroke];
    
    
    
    // Text Drawing
    [[UIColor blackColor] setFill];
    CGPoint center = CGPointMake(percentLabel.frame.origin.x,percentLabel.frame.origin.y);
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:6],
                                  };
    [textContent drawAtPoint:center withAttributes:attributes];
    [overlayView addSubview:percentLabel];
}

@end
