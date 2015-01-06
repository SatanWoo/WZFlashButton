//
//  ViewController.m
//  WZRippleButton
//
//  Created by z on 15-1-6.
//  Copyright (c) 2015年 SatanWoo. All rights reserved.
//

#import "ViewController.h"
#import "WZFlashButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [self.view addSubview:imageView];
    
    // Inner Flash Button with no text
    WZFlashButton *innerFlashButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(100, 200, 200, 60)];
    innerFlashButton.backgroundColor = [UIColor colorWithRed:42.0f/255.0f green:62.0f/255.0f blue:80.0f alpha:1.0f];
    innerFlashButton.clickBlock = ^(void) {
        NSLog(@"Click Done");
    };
    [self.view addSubview:innerFlashButton];
    
    // Inner Flash Button with text
    WZFlashButton *innerFlashTextButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(100, 300, 200, 60)];
    innerFlashButton.backgroundColor = [UIColor colorWithRed:153.0f/255.0f green:204.0f/255.0f blue:0 alpha:1.0f];
    [innerFlashButton setText:@"Hello World!" withTextColor:nil];
    [self.view addSubview:innerFlashTextButton];
    
    // Outer Round Button
    WZFlashButton *outerRoundFlashButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    outerRoundFlashButton.buttonType = WZFlashButtonTypeOuter;
    outerRoundFlashButton.layer.cornerRadius = 25;
    outerRoundFlashButton.flashColor = [UIColor colorWithRed:240/255.f green:159/255.f blue:10/255.f alpha:1];
    outerRoundFlashButton.backgroundColor = [UIColor colorWithRed:0 green:152.0f/255.0f blue:203.0f/255.0f alpha:1.0f];
    [self.view addSubview:outerRoundFlashButton];
    
    // Outer Rectangle Button
    WZFlashButton *outerRectangleFlashButton = [[WZFlashButton alloc] initWithFrame:CGRectMake(200, 50, 100, 60)];
    outerRectangleFlashButton.buttonType = WZFlashButtonTypeOuter;
    [outerRectangleFlashButton setText:@"Hello World!" withTextColor:[UIColor whiteColor]];
    outerRectangleFlashButton.flashColor = [UIColor colorWithRed:248.0f/255.f green:175.0f/255.f blue:160.0f/255.f alpha:1];
    outerRectangleFlashButton.backgroundColor = [UIColor colorWithRed:0 green:152.0f/255.0f blue:203.0f/255.0f alpha:1.0f];
    [self.view addSubview:outerRectangleFlashButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
