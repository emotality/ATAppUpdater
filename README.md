# ATAppUpdater
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
![alt tag](http://www.emotality.com/stackoverflow/ATAppUpdater/ATAppUpdater1.png)

-

````objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [[ATAppUpdater sharedUpdater] forceOpenNewAppVersion:YES];
   return YES;
}
````
![alt tag](http://www.emotality.com/stackoverflow/ATAppUpdater/ATAppUpdater2.png)

## Installation

- Copy `ATAppUpdater` folder in your project
- `#import "ATAppUpdater.h"` in the required class

## Credits

- Reachability: <https://github.com/tonymillion/Reachability>