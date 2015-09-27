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

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface ATAppUpdater : NSObject <UIAlertViewDelegate>

/** Shared instance. [ATAppUpdater sharedUpdater] */
+ (id)sharedUpdater;

/** Checks for newer version and show alert without a cancel button. */
- (void)showUpdateWithForce;

/** Checks for newer version and show alert with a cancel button. */
- (void)showUpdateWithConfirmation;

/** Checks for newer version and show alert with or without a cancel button. */
- (void)forceOpenNewAppVersion:(BOOL)force
__attribute((deprecated("Use 'showUpdateWithForce' or 'showUpdateWithConfirmation' instead.")));

/** Set the UIAlertView title. NSLocalizedString() supported. */
@property (nonatomic, weak) NSString *alertTitle;

/** Set the UIAlertView alert message. NSLocalizedString() supported. */
@property (nonatomic, weak) NSString *alertMessage;

/** Set the UIAlertView update button's title. NSLocalizedString() supported. */
@property (nonatomic, weak) NSString *alertUpdateButtonTitle;

/** Set the UIAlertView cancel button's title. NSLocalizedString() supported. */
@property (nonatomic, weak) NSString *alertCancelButtonTitle;

@end