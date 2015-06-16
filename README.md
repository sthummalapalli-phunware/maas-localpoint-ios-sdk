Localpoint SDK for iOS
==================

Version 2.6.3.1

This is Phunware's iOS SDK for Location Marketing, a location- and notification-based system. Visit http://maas.phunware.com/ for more details and to sign up.

Documentation
------------
- how-tos: https://github.com/phunware/maas-localpoint-ios-sdk/wiki
- API reference: http://phunware.github.io/maas-localpoint-ios-sdk/


Requirements
------------

- iOS 6.0 or greater
- Xcode 5 or greater



Installation
------------

Phunware recommends using [CocoaPods](http://www.cocoapods.org) to integrate the framework. Simply add `pod 'PWLocalpoint'` to your podfile.

Alternatively, you can follow the next steps:

1. Add Localpoint.framework to your Xcode project.
2. In your build settings, verify that the `Framework Search Paths` has an entry for pointing to the Localpoing.framework folder. For example: `$(PROJECT_DIR)/Vendor/Phunware/Localpoint`.

3. The following iOS frameworks are required:
````
CoreLocation.framework
CoreGraphics.framework
libsqlite3.lib
````



Set Up
------------
Add the following key/value to you app Info.plist file:

* Required background modes:
    - `App registers for location updates` This value will allow the app to keep users informed of their location, even while it is running in the background.
    - `App downloads content from the network` This value will allow the app to regularly download and processes small amounts of content from the network. The addition of this value is only required for 2.4.0+ versions of our SDK.
* LPServer :  The environment you will be working on. This value can be `sandbox` for testing and `api` for production.
* LPAppID : The application ID matching the server choice.
* LPBrand :  Your brand name.
* NSLocationAlwaysUsageDescription: The message you want to display on the prompted alert when the user grants the app permission to use the location service.




Documentation
------------

Localpoint documentation is included in the the repository's Documents folder as both HTML and as a .docset. You can also find the latest documentation here: http://phunware.github.io/maas-localpoint-ios-sdk/



Integration
-----------

Localpoint SDK is always running in background. There are no UI elements included in the SDK.

### Start Localpoint service

````objective-c
// Include the Localpoint header file
#import <Localpoint/Localpoint.h>

// Get Localpoint instance
LPLocalpointService *lpService = [LPLocalpointService instance];

// Start it
[lpService start];

// That's it!
````


### Subscribe location events callback

Localpoint provides a `ILPLocationListener` protocol. You can create a listener that implements the protocol's methods and register your listener with the Localpoint SDK's location provider.

````objective-c
LPLocationListener *locationListener = [[LPLocationListener alloc] init];

// Register your location listener
[[lpService getLocationProvider] addListener:locationListener];
````

### Subscribe message events callback

Localpoint provides a `ILPMessageListener` protocol.  You can create a listener that implements the protocol's methods and register your listener with the Localpoint SDK's message provider.

````objective-c
LPMessageListener *messageListener = [[LPMessageListener alloc] init];

// Register your message listener
[[lpService getMessageProvider] addListener:messageListener];
````

### Custom local notification callback

Localpoint provides a `ILPLocalNotificationListener` protocol.  You can create a listener that implements the protocol's methods and set the listener in the `LPLocalpointService` instance.


````objective-c
LPLocalNotificationListener *localNotificationListener = [[LPLocalNotificationListener alloc] init];

// Register your local notification listener
[lpService setLocalNotificationListener:localNotificationListener];
````

### Stop Localpoint service

````objective-c
// Stop Localpoint service
[lpService stop];
````