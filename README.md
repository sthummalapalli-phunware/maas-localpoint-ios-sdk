Localpoint SDK for iOS
==================

Version 2.5.4

Localpoint is a comprehensive location-based and notification customization that allows easy integration with your iOS app. Visit http://www.digby.com/ for more details and to sign up.



Requirements
------------

- iOS 6.0 or greater
- Xcode 4.4 or greater



Installation
------------

Just add Localpoint.framework to your Xcode project.

The following frameworks are required:
````
CoreLocation.framework
CoreGraphics.framework
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
````



Documentation
------------

Localpoint documentation is included in the the repository's Documents folder as both HTML and as a .docset.



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

### Stop Localpoint service

````objective-c
	// Stop Localpoint service
	[lpService stop];
````
