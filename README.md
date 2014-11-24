Localpoint SDK for iOS
==================

Version 2.6.2

Localpoint is a comprehensive location-based and notification customization that allows easy integration with your iOS app. Visit http://www.digby.com/ for more details and to sign up.
For more integration detail, please go https://github.com/phunware/maas-localpoint-ios-sdk/wiki.


Requirements
------------

- iOS 6.0 or greater
- Xcode 5 or greater



Installation
------------

1. Just add Localpoint.framework to your Xcode project.
2. In your build settings, verify that the `Framework Search Paths` has an entry for pointing to the Localpoing.framework folder. For example: `$(PROJECT_DIR)/Vendor/Phunware/Localpoint`.

3. The following iOS frameworks are required:
````
CoreLocation.framework
CoreGraphics.framework
CoreMotion.framework
libsqlite3.lib
````



Set Up
------------
Add the following key/value to you app Info.plist file:
````
Required background modes 
	Value1: App registers for location updates. This will allow your application to get location updates in the background.
	Value2: App downloads content from the network. Note: The addition of this row is only for 2.4.0+ versions of our SDK.
LPServer; Value: sandbox for testing and api for production.
LPAppID; Value: application ID matching the server choice.
LPBrand; Value: your brand name.
NSLocationAlwaysUsageDescription; Value: whatever you want to display on the prompted alert when granting to use GPS location service.
````



Documentation
------------

Localpoint documentation is included in the the repository's Documents folder as both HTML and as a .docset. You can also find the latest documentation here: http://phunware.github.io/maas-localpoint-ios-sdk/



Integration
-----------

Localpoint SDK is always running in background, and none of UI view can be found in the SDK.

### Start Localpoint service

````objective-c
	// Get Localpoint instance
	LPLocalpointService *lpService = [LPLocalpointService instance];
	
	// Start it
	[lpService start];
    
    // That's it!
````


### Subscribe location events callback

Localpoint provide a ILPLocationListener interface, you just need to implement the methods and register it in LPLocationProvider.

````objective-c
	LPLocationListener *locationListener = [[LPLocationListener alloc] init];
	
	// Register your location listener
	[[lpService getLocationProvider] addListener:locationListener];
````

### Subscribe message events callback

Localpoint provide a ILPMessageListener interface, you just need to implement the methods and register it in LPMessageProvider.

````objective-c
	LPMessageListener *messageListener = [[LPMessageListener alloc] init];
	
	// Register your message listener
	[[lpService getMessageProvider] addListener:messageListener];
````

### Custom local notification callback

Localpoint provide a ILPLocalNotificationListener interface, you just need to implement the methods and set it to LPLocalpointService.

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
