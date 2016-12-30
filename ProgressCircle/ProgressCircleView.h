//
//  ProgressCircleView.h
//  ProgressCircle
//
//  Created by Ryan on 12/20/15.
//  Copyright © 2015 Modern Mobile Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressCircleView : UIView

@property (nonatomic) Float64 percent;
@property (nonatomic) Float64 duration;
//@property (nonatomic) CGFloat circleWidth;
@property (nonatomic, retain) UIColor* progressColor;
@property (nonatomic) CGRect diameterRect;

@end
