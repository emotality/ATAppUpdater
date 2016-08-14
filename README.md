# ATAppUpdater 1.7
Checks if there is a newer version of your app in the AppStore and alerts the user to update.

[![Build Status](https://travis-ci.org/emotality/ATAppUpdater.svg?branch=master)](https://travis-ci.org/emotality/ATAppUpdater) 

## Features

- One line of code
- Milliseconds response
- Thread-safe
- Shows version number in alert
- Opens app in AppStore from alert
- Choose not to update now or force user to update
- Localization supported

## Examples

**One line:**

````objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [[ATAppUpdater sharedUpdater] showUpdateWithForce];
   return YES;
}
````
![ATAppUpdater1](http://apptality.ae/assets/ATAppUpdater/ATAppUpdater1.png)
````objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [[ATAppUpdater sharedUpdater] showUpdateWithConfirmation];
   return YES;
}
````
![ATAppUpdater2](http://apptality.ae/assets/ATAppUpdater/ATAppUpdater2.png)

---
**Custom titles + localization:**
````objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   ATAppUpdater *updater = [ATAppUpdater sharedUpdater];
   [updater setAlertTitle:NSLocalizedString(@"Nuwe Weergawe", @"Alert Title")];
   [updater setAlertMessage:NSLocalizedString(@"Weergawe %@ is beskikbaar op die AppStore.", @"Alert Message")];
   [updater setAlertUpdateButtonTitle:@"Opgradeer"];
   [updater setAlertCancelButtonTitle:@"Nie nou nie"];
   [updater showUpdateWithConfirmation];
   return YES;
}
````
![ATAppUpdater3](http://apptality.ae/assets/ATAppUpdater/ATAppUpdater3.png)

## Installation

**Manual:**

- Copy `ATAppUpdater` folder into your project
- Link `SystemConfiguration.framework`
- `#import "ATAppUpdater.h"` in the required class

**CocoaPods:**

- Add to podfile: `pod 'ATAppUpdater'`
- `#import "ATAppUpdater.h"` in the required class

## License

ATAppUpdater is released under the MIT license. See [LICENSE](https://github.com/apptality/ATAppUpdater/blob/master/LICENSE.md) for details.
