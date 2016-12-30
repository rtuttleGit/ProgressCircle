//
//  ViewController.m
//  ProgressCircle
//
//  Created by Ryan on 12/20/15.
//

#import "ViewController.h"
#import "ProgressCircleView.h"

@interface ViewController ()
{
    NSTimer *progressTimer;
    ProgressCircleView *progressView;
}

@property (nonatomic, retain) UIColor* progressColor;
@property (nonatomic) NSInteger diameterNumber;
@property (nonatomic) NSInteger colorIndex;
@property (nonatomic) CGFloat screenWidth;
@property (nonatomic) CGFloat screenHeight;
@property (nonatomic) CGFloat targetPercent;
@property (nonatomic) CGFloat currentPercent;
@property (nonatomic, retain) NSArray *colorArray;

@end

@implementation ViewController

@synthesize screenHeight;
@synthesize screenWidth;
@synthesize targetPercent;
@synthesize currentPercent;
@synthesize colorIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    //Set the background view color
    self.view.backgroundColor = [UIColor whiteColor];
    //Initialize
    
    UIButton *twentyFivePercentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    twentyFivePercentButton.frame = CGRectMake(20, screenHeight-200, 160, 40);
    [twentyFivePercentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [twentyFivePercentButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    twentyFivePercentButton.alpha = 0.7;
    [twentyFivePercentButton setTitle:NSLocalizedString(@"25 Percent",nil) forState:UIControlStateNormal];
    twentyFivePercentButton.backgroundColor = [UIColor grayColor];
    [twentyFivePercentButton addTarget:self action:@selector(changeTo25Percent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twentyFivePercentButton];
    
    UIButton *seventyFivePercentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    seventyFivePercentButton.frame = CGRectMake(screenWidth-180, screenHeight-200, 160, 40);
    [seventyFivePercentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [seventyFivePercentButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    seventyFivePercentButton.alpha = 0.7;
    [seventyFivePercentButton setTitle:NSLocalizedString(@"75 Percent",nil) forState:UIControlStateNormal];
    seventyFivePercentButton.backgroundColor = [UIColor grayColor];
    [seventyFivePercentButton addTarget:self action:@selector(changeTo75Percent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seventyFivePercentButton];
    
    UIButton *changeColorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    changeColorButton.frame = CGRectMake(20, screenHeight-150, 160, 40);
    [changeColorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeColorButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    changeColorButton.alpha = 0.7;
    [changeColorButton setTitle:NSLocalizedString(@"Change Color",nil) forState:UIControlStateNormal];
    changeColorButton.backgroundColor = [UIColor grayColor];
    [changeColorButton addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeColorButton];
    
    UIButton *changeDiameterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    changeDiameterButton.frame = CGRectMake(screenWidth-180, screenHeight-150, 160, 40);
    [changeDiameterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeDiameterButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    changeDiameterButton.alpha = 0.7;
    [changeDiameterButton setTitle:NSLocalizedString(@"Change Diameter",nil) forState:UIControlStateNormal];
    changeDiameterButton.backgroundColor = [UIColor grayColor];
    [changeDiameterButton addTarget:self action:@selector(changeDiameter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeDiameterButton];
    
    UIButton *resetToDefaults = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    resetToDefaults.frame = CGRectMake(20, screenHeight-100, screenWidth - 40, 40);
    [resetToDefaults setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetToDefaults.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    resetToDefaults.alpha = 0.7;
    [resetToDefaults setTitle:NSLocalizedString(@"Reset View",nil) forState:UIControlStateNormal];
    resetToDefaults.backgroundColor = [UIColor grayColor];
    [resetToDefaults addTarget:self action:@selector(resetToDefaults:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetToDefaults];
    
    //Set Default View
    _colorArray = [NSArray arrayWithObjects:[UIColor blueColor], [UIColor redColor], [UIColor greenColor], [UIColor yellowColor], [UIColor orangeColor], [UIColor whiteColor], [UIColor purpleColor], nil];
   
    [self defaultProgressView];
}

- (void)changeSpin
{
        if(progressView.percent < targetPercent)
        {
            progressView.percent = progressView.percent + 1.0;
            [progressView setNeedsDisplay];
        }
        else if(progressView.percent > targetPercent)
        {
            progressView.percent = progressView.percent - 1.0;
            [progressView setNeedsDisplay];
        }
        else{
            currentPercent = progressView.percent;
            [progressTimer invalidate];
            progressTimer = nil;
        }
}


- (void)changeTo25Percent:(UIButton*)button{
    currentPercent = progressView.percent;
    if(currentPercent == 0 || currentPercent == targetPercent)
    {
        targetPercent = 25.0f;
        progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeSpin) userInfo:nil repeats:YES];
    }
}

- (void)changeTo75Percent:(UIButton*)button{
    currentPercent = progressView.percent;
    if(currentPercent == 0 || currentPercent == targetPercent)
    {
        targetPercent = 75.0f;
        progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeSpin) userInfo:nil repeats:YES];
    }
}

- (void)changeColor:(UIButton*)button{
    colorIndex += 1;
    if(colorIndex >= _colorArray.count) { colorIndex = 0; }
    _progressColor = _colorArray[colorIndex];
    progressView.progressColor = _progressColor;
    [progressView setNeedsDisplay];
}

- (void)changeDiameter:(UIButton*)button{
    _diameterNumber += 24;
    if(_diameterNumber > 224) { _diameterNumber = 100; }
    progressView.diameterRect = CGRectMake(screenWidth/2 - _diameterNumber/2, screenHeight/2 - 200, _diameterNumber, _diameterNumber);
    [progressView setNeedsDisplay];
}

- (void)resetToDefaults:(UIButton*)button{
    [progressView removeFromSuperview];
    [progressTimer invalidate];
    progressTimer = nil;
    [self defaultProgressView];
}

-(void)defaultProgressView{
    _diameterNumber = 100;
    colorIndex = 0;
    _progressColor = _colorArray[colorIndex];
    progressView = [[ProgressCircleView alloc] initWithFrame:CGRectMake(screenWidth/2 - _diameterNumber/2, screenHeight/2 - 200, _diameterNumber, _diameterNumber)];
    progressView.diameterRect = CGRectMake(screenWidth/2 - _diameterNumber/2, screenHeight/2 - 200, _diameterNumber, _diameterNumber);
    progressView.clipsToBounds = YES;
    progressView.percent = 0.0f;
    progressView.progressColor = _progressColor;
    [self.view addSubview:progressView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
