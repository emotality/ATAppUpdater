This is a fork of ATAppUpdater, which I have rewritten in Swift 2.0 and added another function.

The function allows you to pass a minimum force version String, which will also be checked against the User's currently installed App version and will force the user to update if his Version is lower than the passed minimum version String.

## Example Usage by passing the minimum version String fetched from Parse.com

````objc
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
   PFConfig.getConfigInBackgroundWithBlock { (config : PFConfig?, error:NSError?) -> Void in
      MGAppUpdater.sharedUpdater().showUpdateWithForce(config.objectForKey("MinimumForceVersion") as? String)
   }
}
````


# ATAppUpdater 1.7
Checks if there is a newer version of your app in the AppStore and alerts the user to update.

[![Build Status](https://travis-ci.org/apptality/ATAppUpdater.svg?branch=master)](https://travis-ci.org/apptality/ATAppUpdater) 

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
![ATAppUpdater1](http://demo.apptality.co.za/ATAppUpdater/images/1.6/ATAppUpdater1.png)
````objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [[ATAppUpdater sharedUpdater] showUpdateWithConfirmation];
   return YES;
}
````
![ATAppUpdater2](http://demo.apptality.co.za/ATAppUpdater/images/1.6/ATAppUpdater2.png)

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
![ATAppUpdater3](http://demo.apptality.co.za/ATAppUpdater/images/1.6/ATAppUpdater3.png)

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