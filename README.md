# IBM Cloud AppLaunch Swift Sample - Poll

Sample Application to demonstrate capabilities of IBM Cloud AppLaunch Service 

**Note** : This application is still under Development


# IBM Cloud AppLaunch Swift Sample - Poll


The [Bluemix App Launch service](https://console.bluemix.net/catalog/services/app-launch) App Launch service on Bluemix helps in controlled reach of app features. It provides a unified service to customize and personalize your applications to different audience with just few clicks.

Ensure that you go through [Bluemix App Launch service documentation](https://console.bluemix.net/docs/services/app-launch/index.html) before you start.

## Contents
- [Setup App Launch Service](#setup-app-launch-service)
	 - [Creating the service](#creating-the-service)
	 - [Creating a feature](#creating-a-feature)
	 - [Creating an audience](#creating-an-audience)
	 - [Creating an engagement](#creating-an-engagement)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Initialize SDK](#initialize-sdk)
    - [Include client App Launch SDK](#include-client-app-launch-sdk)
    - [Initialize](#initialize) 
    - [Register](#register) 
    - [Update User](#update-user)   
- [Actions](#actions)
- [Feature Toggle](#feature-toggle)
    - [Check if feature is enabled](#check-if-feature-is-enabled)
    - [Get variable for feature](#get-variable-for-feature)
- [Metrics](#metrics)
    - [Send Metrics](#send-metrics)
- [Applaunch Android SDK](#applaunch-android-sdk)    
- [Samples and videos](#samples-and-videos)

##Setup App Launch Service
### Creating the service
![Create feature](https://github.com/ibm-bluemix-mobile-services/bms-clientsdk-android-applaunch/blob/development/Images/create_service.gif)
### Creating a feature
![Create feature](https://github.com/ibm-bluemix-mobile-services/bms-clientsdk-android-applaunch/blob/development/Images/create_feature.gif)
### Creating an audience
![Create audience](https://github.com/ibm-bluemix-mobile-services/bms-clientsdk-android-applaunch/blob/development/Images/create_audience.gif)
### Creating an engagement
![Create engagement](https://github.com/ibm-bluemix-mobile-services/bms-clientsdk-android-applaunch/blob/development/Images/create_engagement.gif)




     ```
### Initialize
Initiaze App to connect with bluemix application by providing  details <Regions> , <ApplicationGUID> , <CLientSecret> in **LoginViewController.swift** file
```
AppLaunch.sharedInstance.initialize(region: <Region>, appId: <appGUID>, clientSecret: <clientSecret>, config: config, user: user)
```


Where `<Region>` specifies the location where the app is hosted. You can use any of the following values:

- `.US_SOUTH`
- `.UNITED_KINGDOM`
- `.SYDNEY`

**Note: Currently AppLaunch Avalable in US_SOUTH Region Only**

The `appGUID` is the app launch app GUID value, while `clientSecret` is the appLaunch client secret value which can be obtained from the service console.

### Register
To register the user invoke ```AppLaunchUser.Builder()``` api: 

```
// Register the user
              let user = AppLaunchUser.Builder(userId: "<username>").custom(key: "<attributeName>", stringValue: "<attributeValue>").build()
```

where `<username>` is custom unique userid, `<attributeName>` & `<attributeValue>` is attribute name and value as seen in Audience

## Actions

### Get Actons

Use the ` getActions()` API to fetch all the actions assosicated with the application. 

    getActions(_ completionHandler: @escaping AppLaunchCompletionHandler)

## Feature Toggle

### Check if feature is enabled

Use the ` checkIfFeatureEnabled()` API to check if a particular feature is enabled for the application. This api returns true if the feature is enable for the application else false in `ViewCOntroller.swift`


     checkIfFeatureEnabled()
 
 
Edit the sample applications ```ViewCOntroller.swift > checkIfFeatureEnabled()``` to update your feature code

### Get variable for feature
Use the `AppLaunch.sharedInstance.getPropertyofFeature()` to fetch the variable corresponding to a feature

    AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "<featurecode>", propertyCode: "<propertycode>")
    

This api returns the varaible corresponding to the variable code for a particular feature.

Edit the sample applications ```ViewCOntroller.swift > checkIfFeatureEnabled()``` to update your property code

## Metrics

### Send Metrics

To send metrics to the server use the `AppLaunch.sharedInstance.sendMetrics()` api. This sends the metrics information to the server

```
 AppLaunch.sharedInstance.sendMetrics(codes: ["<MetricCode>"])
```
Edit the sample applications ```ViewCOntroller.swift > buttonClicked()``` to update your metriccode

## Applaunch Swift SDK

For more information on the Applaunch Swift SDK api, visit - [AppLaunch Swift SDK](https://github.com/ibm-bluemix-mobile-services/bms-clientsdk-swift-applaunch)

### Learning More

* Visit the **[Bluemix Developers Community](https://developer.ibm.com/bluemix/)**.

### Connect with Bluemix

[Twitter](https://twitter.com/ibmbluemix)|
[YouTube](https://www.youtube.com/watch?v=dQ1WcY_Ill4) |
[Blog](https://developer.ibm.com/bluemix/blog/) |
[Facebook](https://www.facebook.com/ibmbluemix) |
[Meetup](http://www.meetup.com/bluemix/)

=======================
Copyright 2016-17 IBM Corp.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
