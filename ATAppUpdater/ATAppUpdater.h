///////// ----------------------------------------------------------------------
////////  Created by Jean-Pierre Fourie
///////  Copyright (c) 2015 Apptality Mobile Development. All rights reserved.
//////  http://www.apptality.co.za - Always deliver more than expected.
/////
////  ATAppUpdater
///  https://github.com/emotality/ATAppUpdater
// ----------------------------------------------------------------------


@interface ATAppUpdater : NSObject

+ (id)sharedUpdater;
- (void)forceOpenNewAppVersion:(BOOL)force;

@end


@interface ATUpdateAlert : UIAlertView <UIAlertViewDelegate>

+ (UIAlertView *)alertUpdateForVersion:(NSString *)version withURL:(NSString *)appUrl withForce:(BOOL)force;

@end
