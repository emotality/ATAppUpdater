//
//  ViewController.m
//  ATAppUpdater
//
//  Created by Jean-Pierre Fourie on 2015/09/14.
//  Copyright © 2015 Apptality. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.frame];
    [bg setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:bg];
    
    UIButton *website = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT-55, SCREEN_WIDTH-40, 35)];
    [website setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.1f]];
    [website setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [website setTitle:@"github.com/apptality" forState:UIControlStateNormal];
    [website setShowsTouchWhenHighlighted:YES];
    [website.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20]];
    [website.layer setCornerRadius:5.5f];
    [website.layer setBorderWidth:1.0f];
    [website.layer setBorderColor:[UIColor whiteColor].CGColor];
    [website addTarget:self action:@selector(openWebsite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:website];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)openWebsite
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/apptality"]];
}

@end
