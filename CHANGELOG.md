Localpoint iOS SDK - Change Logs
==========

Version 2.6.3.1 *(6/15/2015)*
----------------------------
* Fix the crash when tapping a notification which doesn't have promotion.

Version 2.6.3 *(5/1/2015)*
----------------------------
* Change location update method to use significant location update instead of standard location update.
* Change the geofence monitoring algorithm to remove the secondary monitoring regions.
* Change the LP server request payload add add some nodes like `inside`, `entries` and `exit`.
* Move the geofence breach algorithm from server side to client side.

Version 2.6.2 *(11/17/2014)*
----------------------------
* Disable motion activity from SDK by default, in the meanwhile, add an API to enable.
* Stop sending any HTTP request to LP server before registration is completed.
* Add retry mechanism for registration and Geofence download.
* Take IDFV or IDFA as device identifier instead of OpenUUID.
* Add additional device identifier information such as encode type in request payload.

Version 2.6.1 *(09/26/2014)*
----------------------------
* Fixed issue: sometimes the MessageId is missing from the Local Notification user info dictionary.

Version 2.6.0 *(09/18/2014)*
----------------------------
* Change to adopt to new API and new features for iOS 8
* Improved battery usage & geofencing accuracy by using Fused location provider, Geofencing APIs and Activity recognition
* Added ability to customize location notifications programmatically. Customizations include overriding the local notification title and message body or supressing the local notification entirely.

