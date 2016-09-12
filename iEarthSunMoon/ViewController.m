//
//  ViewController.m
//  iEarthSunMoon
//
//  Created by Bui Duc Khanh on 9/12/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSTimer *timer;
    
    UIImageView *sun;
    UIImageView *earth;
    UIImageView *moon;
    
    CGPoint sunCenter; //CoreGraphics Point
    
    CGFloat distanceEarthToSun;
    CGFloat distanceEarthToMoon;
    
    CGFloat angleEarth;  //goc quay trai dat quanh mat troi
    CGFloat angleMoon;  //goc quay mặt trăng quanh trái đất
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initGUI];
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:(1/60.0)            // 60 fps
                                             target:self
                                           selector:@selector(animate)
                                           userInfo:nil
                                            repeats:true];
    
}
- (void) initGUI {
    sun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sun.png"]];
    earth = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth.png"]];
    moon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moon"]];
    
    
    sunCenter = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
    
    NSLog(@"%f", self.view.frame.size.width * 0.5);
    
    distanceEarthToSun = 145;
    distanceEarthToMoon = 52;
    

    sun.center = sunCenter;
    
    angleEarth = 0.0;
    angleMoon = 0.0;
    
    [self animate];
    
    
    [self.view addSubview:sun];
    [self.view addSubview:earth];
    [self.view addSubview:moon];
    
}


- (void) animate {
    angleEarth += 2 * M_PI / 2190.0; // tổng thời gian quay 1 vòng sẽ là 36.5s tính theo công thức 2 * PI / angleEarth = 36.5 / (1/60)
    
    angleMoon += 2 * M_PI / 163.8; // tổng thời gian quay 1 vòng sẽ là 36.5s tính theo công thức 2 * PI / angleMoon = 2.73 / (1/60)
    
    CGPoint earthCenter = CGPointMake(sunCenter.x + distanceEarthToSun * cos(angleEarth),
                                      sunCenter.y + distanceEarthToSun * sin(angleEarth));
    
    
    // Toạ độ mặt trăng tính tương tự như toạ độ trái đất với mặt trời
    CGPoint moonCenter = CGPointMake(earthCenter.x + distanceEarthToMoon * cos(angleMoon),
                                      earthCenter.y + distanceEarthToMoon * sin(angleMoon));
    
    earth.center = earthCenter;
    moon.center = moonCenter;
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}



@end
