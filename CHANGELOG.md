Localpoint iOS SDK - Change Logs
==========

Version 2.6.2 *(11/17/2014)*
----------------------------
* Disable motion activity from SDK by default, in the meanwhile, add an API to enable.
* Stop sending any HTTP request to LP server before registration is completed.
* Add retry mechanism for registration and Geofence download.
* Add identifier payload to request JSON.

Version 2.6.1 *(09/26/2014)*
----------------------------
* Fixed issue: sometimes the MessageId is missing from the Local Notification user info dictionary.

Version 2.6.0 *(09/18/2014)*
----------------------------
* Change to adopt to new API and new features for iOS 8
* Improved battery usage & geofencing accuracy by using Fused location provider, Geofencing APIs and Activity recognition
* Added ability to customize location notifications programmatically. Customizations include overriding the local notification title and message body or supressing the local notification entirely.

