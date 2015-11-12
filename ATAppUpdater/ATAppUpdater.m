/*
 Created by Jean-Pierre Fourie
 Copyright (c) 2015 Apptality <info@apptality.co.za>
 Website: http://www.apptality.co.za
 GitHub: https://github.com/apptality
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

#import "ATAppUpdater.h"

@implementation ATAppUpdater


#pragma mark - Init


+ (id)sharedUpdater
{
    static ATAppUpdater *sharedUpdater;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUpdater = [[ATAppUpdater alloc] init];
    });
    return sharedUpdater;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.alertTitle = @"New Version";
        self.alertMessage = @"Version %@ is available on the AppStore.";
        self.alertUpdateButtonTitle = @"Update";
        self.alertCancelButtonTitle = @"Not Now";
    }
    return self;
}


#pragma mark - Instance Methods


- (void)showUpdateWithForce
{
    BOOL hasConnection = [self hasConnection];
    if (!hasConnection) return;
    
    [self checkNewAppVersion:^(BOOL newVersion, NSString *version) {
        if (newVersion) {
            [[self alertUpdateForVersion:version withForce:YES] show];
        }
    }];
}

- (void)showUpdateWithConfirmation
{
    BOOL hasConnection = [self hasConnection];
    if (!hasConnection) return;
    
    [self checkNewAppVersion:^(BOOL newVersion, NSString *version) {
        if (newVersion) {
            [[self alertUpdateForVersion:version withForce:NO] show];
        }
    }];
}

- (void)forceOpenNewAppVersion:(BOOL)force
{
    BOOL hasConnection = [self hasConnection];
    if (!hasConnection) return;
    
    [self checkNewAppVersion:^(BOOL newVersion, NSString *version) {
        if (newVersion) {
            [[self alertUpdateForVersion:version withForce:force] show];
        }
    }];
}


#pragma mark - Private Methods


- (BOOL)hasConnection
{
    const char *host = "itunes.apple.com";
    BOOL reachable;
    BOOL success;
    
    // Link SystemConfiguration.framework! <SystemConfiguration/SystemConfiguration.h>
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host);
    SCNetworkReachabilityFlags flags;
    success = SCNetworkReachabilityGetFlags(reachability, &flags);
    reachable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
    CFRelease(reachability);
    return reachable;
}

NSString *appStoreURL = nil;

- (void)checkNewAppVersion:(void(^)(BOOL newVersion, NSString *version))completion
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier = bundleInfo[@"CFBundleIdentifier"];
    NSString *currentVersion = bundleInfo[@"CFBundleShortVersionString"];
    NSURL *lookupURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", bundleIdentifier]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void) {
        
        NSData *lookupResults = [NSData dataWithContentsOfURL:lookupURL];
        if (!lookupResults) {
            completion(NO, nil);
            return;
        }
        
        NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:lookupResults options:0 error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            NSUInteger resultCount = [jsonResults[@"resultCount"] integerValue];
            if (resultCount){
                NSDictionary *appDetails = [jsonResults[@"results"] firstObject];
                NSString *appItunesUrl = [appDetails[@"trackViewUrl"] stringByReplacingOccurrencesOfString:@"&uo=4" withString:@""];
                NSString *latestVersion = appDetails[@"version"];
                if ([latestVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                    appStoreURL = appItunesUrl;
                    completion(YES, latestVersion);
                } else {
                    completion(NO, nil);
                }
            } else {
                completion(NO, nil);
            }
        });
    });
}

- (UIAlertView *)alertUpdateForVersion:(NSString *)version withForce:(BOOL)force
{
    NSString *msg = [NSString stringWithFormat:self.alertMessage, version];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.alertTitle message:msg delegate:self cancelButtonTitle:force ? nil:self.alertUpdateButtonTitle otherButtonTitles:force ? self.alertUpdateButtonTitle:self.alertCancelButtonTitle, nil];
    return alert;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSURL *appUrl = [NSURL URLWithString:appStoreURL];
        if ([[UIApplication sharedApplication] canOpenURL:appUrl]) {
            [[UIApplication sharedApplication] openURL:appUrl];
        } else {
            UIAlertView *cantOpenUrlAlert = [[UIAlertView alloc] initWithTitle:@"Not Available" message:@"Could not open the AppStore, please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [cantOpenUrlAlert show];
        }
    }
}

@end