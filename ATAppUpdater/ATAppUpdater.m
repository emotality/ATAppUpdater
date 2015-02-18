///////// ----------------------------------------------------------------------
////////  Created by Jean-Pierre Fourie
///////  Copyright (c) 2015 Apptality Mobile Development. All rights reserved.
//////  http://www.apptality.co.za - Always deliver more than expected.
/////
////  ATAppUpdater
///  https://github.com/emotality/ATAppUpdater
// ----------------------------------------------------------------------


#import "ATAppUpdater.h"
#import "Reachability.h"

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


- (void)forceOpenNewAppVersion:(BOOL)force
{
    Reachability *connection = [Reachability reachabilityWithHostname:@"itunes.apple.com"];
    BOOL hasConnection = [connection isReachable];
    if (!hasConnection) return;
    
	[self checkNewAppVersionWithBlock:^(BOOL newVersion, NSString *appUrl, NSString *version) {
		if (newVersion) [[ATUpdateAlert alertUpdateForVersion:version withURL:appUrl withForce:force] show];
	}];
}

- (void)checkNewAppVersionWithBlock:(void(^)(BOOL newVersion, NSString *appUrl, NSString *version))block
{
	NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
	NSString *bundleIdentifier = [bundleInfo valueForKey:@"CFBundleIdentifier"];
	NSString *currentVersion = [bundleInfo objectForKey:@"CFBundleShortVersionString"];
	NSURL *lookupURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", bundleIdentifier]];
	NSData *lookupResults = [NSData dataWithContentsOfURL:lookupURL];
	NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:lookupResults options:0 error:nil];
	
	NSUInteger resultCount = [[jsonResults objectForKey:@"resultCount"] integerValue];
	if (resultCount){
		NSDictionary *appDetails = [[jsonResults objectForKey:@"results"] firstObject];
		NSString *appItunesUrl = [[appDetails objectForKey:@"trackViewUrl"] stringByReplacingOccurrencesOfString:@"&uo=4" withString:@""];
		NSString *latestVersion = [appDetails objectForKey:@"version"];
		if (![latestVersion isEqualToString:currentVersion]) {
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
	
	if (force) 	alert = [[UIAlertView alloc] initWithTitle:@"New Version" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"Update Now", nil];
	else alert = [[UIAlertView alloc] initWithTitle:@"New Version" message:msg delegate:self cancelButtonTitle:@"Update" otherButtonTitles:@"Not Now", nil];
	
	return alert;
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreURL]];
}

@end
