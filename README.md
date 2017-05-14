# ATAppUpdater 2.0
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
- Delegate methods

## Examples

**One line:**

````objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [[ATAppUpdater sharedUpdater] showUpdateWithForce];
   return YES;
}
````
![ATAppUpdater1](https://www.emotality.com/development/GitHub/ATAppUpdater-1.png)
````objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [[ATAppUpdater sharedUpdater] showUpdateWithConfirmation];
   return YES;
}
````
![ATAppUpdater2](https://www.emotality.com/development/GitHub/ATAppUpdater-2.png)

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
   [updater setDelegate:self]; // Optional
   [updater showUpdateWithConfirmation];
   return YES;
}
````
![ATAppUpdater3](https://www.emotality.com/development/GitHub/ATAppUpdater-3.png)

---
**Delegate methods:**
````objc
- (void)appUpdaterDidShowUpdateDialog;
- (void)appUpdaterUserDidLaunchAppStore;
- (void)appUpdaterUserDidCancel;
````

## Installation

**Manual:**

- Copy `ATAppUpdater` folder into your project
- Link `SystemConfiguration.framework`
- `#import "ATAppUpdater.h"` in the required class
- Add the `<ATAppUpdaterDelegate>` protocol if needed

**CocoaPods:**

- Add to podfile: `pod 'ATAppUpdater'`
- `#import "ATAppUpdater.h"` in the required class
- Add the `<ATAppUpdaterDelegate>` protocol if needed

## License

ATAppUpdater is released under the MIT license. See [LICENSE](https://github.com/emotality/ATAppUpdater/blob/master/LICENSE.md) for details.
