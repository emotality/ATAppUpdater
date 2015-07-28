# ATAppUpdater 1.2
Checks if there is a newer version of your app in the AppStore and alerts the user to update.

## Features

- One line of code
- Milliseconds response
- Shows version number in alert
- Opens app in AppStore from alert
- Choose not to update now or force user to update
- Thread-safe

## Examples

````objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [[ATAppUpdater sharedUpdater] forceOpenNewAppVersion:NO];
   return YES;
}
````
![alt tag](http://www.apptality.co.za/images/github/ATAppUpdater1.png)

-

````objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [[ATAppUpdater sharedUpdater] forceOpenNewAppVersion:YES];
   return YES;
}
````
![alt tag](http://www.apptality.co.za/images/github/ATAppUpdater2.png)

## Installation

**Manual:**

- Install Reachability code into your project: <https://github.com/tonymillion/Reachability>
- Copy `ATAppUpdater` folder in your project
- Link `SystemConfiguration.framework`
- `#import "ATAppUpdater.h"` in the required class

**CocoaPods:**

- Add to podfile: `pod 'ATAppUpdater', '~> 1.2'`
- `#import "ATAppUpdater.h"` in the required class

## Credits

- Reachability: <https://github.com/tonymillion/Reachability>

## License

ATAppUpdater is released under the MIT license. See LICENSE for details.
