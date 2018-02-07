# IBM Cloud AppLaunch Swift Sample - Poll

### Description
Sample swift application to demonstrate a classic usage of App Launch Service using a simple poll feature.

### Overview
The following are the AppLaunch usecases which are covered with this sample

- Feature Toggle/ Rollback 

- Test Feature Variants (A/B testing)

- App Customization by user type

- In App Message

### Prerequisites

- [GIT](https://git-scm.com/)
- [AppLaunch Service Instance on IBM Cloud](https://console.bluemix.net/docs/services/app-launch/developer-overview.html#developer-overview)
- [Xcode](https://developer.apple.com/xcode/)
- [Cocoapods](https://cocoapods.org/#get_started)

### Supported Levels

- iOS 10 +
- Swift 4

## AppLaunch Concepts

#### Concept 1 - Remote App Customisation

A most common use case is where an app developer would want to change app background, a button text or certain widget placement in the app once after the app is published to the Appstore. Another Appstore publish might be an overkill, hence developers would prefer an over-the-air update. This gives developers a much-needed flexibility to manipulate app behavior.

Let's say you would like a button that pop's up a Poll question with yes-no buttons. In the App Launch service Console you will configure this app attributes and later in your app, you will use the SDK APIs.

 - **Feature** - A feature is equivalent to a Java class where you define class members. 
	 - Let's call this feature - **Ask Poll**
	 - Define properties in this feature
		 - property 1 - popUpText
		 - property 2 - popUpYes
		 - property 3 - popUpNo
 - **Audience** - An audience is a collection of attributes that define the characteristics of an audience segment. Let's say you'd like to group all 'Registered' customers, then you will define an Audience, called RegisteredCustomers with an attribute in it, called UserType with a value set to 'Registered'. Later during the app development you will initialize your app by setting an attribute with {'Type':'Registered'}. This initialization will cluster that app (the device) into a 'Registered Users' audience. 
	 - Let's define an audience called, **All Users** 
	 - Set its value to 'Registered,Guest'
 - **Engagement** - An engagement is an instantiation of a Feature with properties initialized and attaching one of the pre-defined audiences. For our AskPoll feature, we will,
	 - Create an Engagement, called - **Ask Poll Engagement**
		 - Initialize AskPoll feature with,
			 - popUpText = "Feeling good?"
			 - popUpYes = "Absolutely"
			 - popUpNo = "Nah"
		 - Initialize Audience,
			 - Audience="PopUpSegment"

Once the above is defined in the Console, in your code you will initialize the service and call the registration API passing in,
 ```
 {"Type":"Registered"} or {"Type":"Guest"}
 ```
 The app can now be coded to utilize these Feature parameters to set the Poll question and the two button's label. That's it - the app will load the Feature parameters during app initialization. If the text is updated then the updated is text is fetched during the next app initialization or based on Application Refresh Policy which is set using AppLaunch SDK.
 
#### Concept 2 - Remote Feature Toggle
This is one of the most often asked feature and the easiest to accomplish using the App Launch Service. 
 
 - **Feature** - No change
 - **Audience** - No change
 - **Engagement** - In the App Launch Service Console if the engagement, "Ask Poll Engagement" is paused then the logic to check for the feature fails and the button, Take Poll will never be displayed. Resume it, then the button is displayed.
 
In your code surround the app logic to check if a feature is defined. For example, to display the 'Poll' button surround the display logic with a check for the feature, called 'Ask Poll'.


#### Concept 3 - Vary App Customisation by percentage of Users

Often Developers would want to create multiple variants of Feature properties and apply them to a different percentage of users. For example, in the Poll example, fifty percentage of users should see one variation of the poll question and the remaining fifty should see variation of the same question. The idea is to perform an A/B test on users to arrive at the more suitable question.

 - **Feature** - No change
 - **Audience** - No change
 - **Engagement** - Engagement allows you to create multiple Feature instances (variations) by setting a percentage for each instance. For example,
	 - Variant 1 (50%)
		 - popUpText - “Is the new feature making a difference?”
		 - popUpYes  - “Yes”
		 - popUpNo - “No”
	 - Variant 2 (50%)
		 - popUpText - “How do you like the new feature?”
		 - popUpYes  - “Great”
		 - popUpNo - “Not Really”
 - Code - No change in the code since the App Launch Service handles the audience segmentation.

#### Concept 4 - App Customisation by audiences
This is perhaps the most advanced and the most powerful feature that App Launch Service supports. Take Poll feature, for example, if you would like to create two audiences, Registered users and Guest users and tailor app customisation for each audience then user experience can be customised for different devices.

 - **Feature** - No change
 - **Audience** - Earlier we had a single audience, called All Users. We will change this to include two separate audiences, Registered Users and Guest Users.
	 - 	Let's define an audience called, **Registered Users** 
	 - Set its value to 'Registered'
	 - 	Let's define another audience called, **Guest Users** 
	 - Set its value to 'Guest'
 - Engagement - As defined in Concept 1 an engagement instantiates a feature by setting values. In this case, we will define two engagements.
	 - Create an Engagement, called - **Registered Users Ask Poll Engagement**
		 - Initialize AskPoll feature with,
			 - popUpText = "How are you feeling today?"
			 - popUpYes = "Absolutely"
			 - popUpNo = "Nah"
		 - Initialize Audience,
			 - Audience="**Registered Users**"
	 - Create a second engagement, called **Guest Users Ask Poll Engagement**
		 - Initialize AskPoll feature with,
			 - popUpText = "Feeling good today?"
			 - popUpYes = "Yes"
			 - popUpNo = "No"
		 - Initialize Audience,
			 - Audience="**Guest Users**"
Note - you may create variants within each engagement, for example, within Guest Users Engagement you may apply **Concept 3**.

#### Metrics
A hidden gem inside App Launch Service is collecting metrics. App Launch Service allows extensive support to embed metric collection hooks, across all the above four concepts. These metrics will help you evaluate results of A/B testing, Feature performance, etc.

Next step, read App Launch documentation here and try out one of the samples here.


### Installation 

- Clone this repository by running following command in command-line window:

  `git clone https://github.com/ibm-cloud-applaunch/sample-swift-poll.git`

- From a command-line window, navigate to the project's root folder and run the command:

	 - `pod update` 
	 - `pod install`  

	This step ensure loads the latest release of AppLaunch SDK into the Application.

- Add the AppLaunch service configurations keys which can be viewed in Settings Section  of AppLaunch Service Console in `LoginViewController.swift`

	```
	AppLaunch.sharedInstance.initialize(region: .US_SOUTH, appId: "application-ID", clientSecret: "client-Secret", config: config, user: user)
	```
	
	- `application-ID` : App GUID value
	- `client-Secret` : Client Secret value

- Update various feature/property/metric codes  in `ViewController.swift`. These values can be viewed/downloaded from the JSON file after creating the feature in App Launch Console

	- `AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_p1ie0h4t3")`
  - `popUpText = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_p1ie0h4t3", propertyCode: "_1kbhwoivq")`
  - `AppLaunch.sharedInstance.sendMetrics(codes: ["_ycc4tikio"])`
 

- Run the application in the iOS Simulator or physical device using Xcode. Login as a guest/registered user to use Poll feature.

 
### Learn More

* Visit the **[IBM App Launch Docs](https://console-regional.ng.bluemix.net/docs/services/app-launch/index.html#gettingstartedtemplate)**. 

## License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissio ns and
limitations under the License.


Apache 2.0 © [IBM Mobile](mailto:ibmmobile@ibm.com)
