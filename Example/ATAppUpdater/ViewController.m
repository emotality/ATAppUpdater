//
//  ViewController.m
//  ATAppUpdater
//
//  Created by Jean-Pierre Fourie on 2017/05/14.
//  Copyright © 2017 emotality. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Change to your bundle identifier and increase the bundle version number to test.
    
    BOOL showCutomAlert = false;
    
    if (showCutomAlert) {
        // Custom
        ATAppUpdater *updater = [ATAppUpdater sharedUpdater];
        [updater setAlertTitle:NSLocalizedString(@"Nuwe Weergawe", @"Alert Title")];
        [updater setAlertMessage:NSLocalizedString(@"Weergawe %@ is beskikbaar op die AppStore.", @"Alert Message")];
        [updater setAlertUpdateButtonTitle:@"Opgradeer"];
        [updater setAlertCancelButtonTitle:@"Nie nou nie"];
        [updater setDelegate:self]; // Optional
        [updater showUpdateWithConfirmation];
        
    } else {
        // Simple
        [[ATAppUpdater sharedUpdater] setDelegate:self]; // Optional
        [[ATAppUpdater sharedUpdater] showUpdateWithConfirmation]; // OR [[ATAppUpdater sharedUpdater] showUpdateWithForce];
    }
}

#pragma mark - ATAppUpdater Delegate

#warning When using delegate, remember to add the ATAppUpdaterDelegate protocol: @interface ViewController : UIViewController <ATAppUpdaterDelegate>

- (void)appUpdaterDidShowUpdateDialog
{
    NSLog(@"appUpdaterDidShowUpdateDialog");
}

- (void)appUpdaterUserDidLaunchAppStore
{
    NSLog(@"appUpdaterUserDidLaunchAppStore");
}

- (void)appUpdaterUserDidCancel
{
    NSLog(@"appUpdaterUserDidCancel");
}

@end
