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


+ (id)sharedUpdater
{
    static ATAppUpdater *sharedUpdater;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUpdater = [[ATAppUpdater alloc] init];
    });
    return sharedUpdater;
}


- (BOOL)hasConnection
{
    const char *host = "itunes.apple.com";
    BOOL reachable;
    BOOL success;
    
    // Needs SystemConfiguration.framework! <SystemConfiguration/SystemConfiguration.h>
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host);
    SCNetworkReachabilityFlags flags;
    success = SCNetworkReachabilityGetFlags(reachability, &flags);
    reachable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
    CFRelease(reachability);
    return reachable;
}

- (void)forceOpenNewAppVersion:(BOOL)force
{
    BOOL hasConnection = [self hasConnection];
    if (!hasConnection) return;
    
    [self checkNewAppVersionWithBlock:^(BOOL newVersion, NSString *appUrl, NSString *version) {
        if (newVersion) {
            [[ATUpdateAlert alertUpdateForVersion:version withURL:appUrl withForce:force] show];
        }
    }];
}

- (void)checkNewAppVersionWithBlock:(void(^)(BOOL newVersion, NSString *appUrl, NSString *version))block
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier = [bundleInfo valueForKey:@"CFBundleIdentifier"];
    NSString *currentVersion = [bundleInfo objectForKey:@"CFBundleShortVersionString"];
    NSURL *lookupURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", bundleIdentifier]];
    
    NSData *lookupResults = [NSData dataWithContentsOfURL:lookupURL];
    if (!lookupResults) {
        block(NO, nil, currentVersion);
        return;
    }
    
    NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:lookupResults options:0 error:nil];
    
    NSUInteger resultCount = [[jsonResults objectForKey:@"resultCount"] integerValue];
    if (resultCount){
        NSDictionary *appDetails = [[jsonResults objectForKey:@"results"] firstObject];
        NSString *appItunesUrl = [[appDetails objectForKey:@"trackViewUrl"] stringByReplacingOccurrencesOfString:@"&uo=4" withString:@""];
        NSString *latestVersion = [appDetails objectForKey:@"version"];
        if ([latestVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
            block(YES, appItunesUrl, latestVersion);
        } else {
            block(NO, nil, currentVersion);
        }
    } else {
        block(NO, nil, currentVersion);
    }
}

@end


@implementation ATUpdateAlert

NSString *appStoreURL = nil;

+ (UIAlertView *)alertUpdateForVersion:(NSString *)version withURL:(NSString *)appUrl withForce:(BOOL)force
{
    appStoreURL = appUrl;
    UIAlertView *alert = nil;
    NSString *msg = [NSString stringWithFormat:@"Version %@ is available on the AppStore.", version];
    
    if (force) alert = [[UIAlertView alloc] initWithTitle:@"New Version" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"Update Now", nil];
    else alert = [[UIAlertView alloc] initWithTitle:@"New Version" message:msg delegate:self cancelButtonTitle:@"Update" otherButtonTitles:@"Not Now", nil];
    return alert;
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreURL]];
}

@end
