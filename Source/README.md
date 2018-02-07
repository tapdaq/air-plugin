# AIR Native Extension for Tapdaq SDK

Target iOS version is 8.0
Minimum AIR SDK version is 27 ( for iOS projects )!!!
Previous versions don't support dynamic frameworks!
https://tracker.adobe.com/#/view/AIR-4198407
https://tracker.adobe.com/#/view/AIR-4198408

Target application should use AIR 27 and include Frameworks directory into target build ( don't place  additional frameworks only ones you use in the application otherwise it will give Sign Error!!!  )
To avoid signing problems evert shared Framework for iOS should be prepared before package ( it should have no additional scripts/stuff like resource bundles, bash scripts etc there except library, headers, modules and plist).

## Versioning the extensions
`Tapdaq/extension.xml` has versionNumber variable. Please change it accordingly for every new release/develop build to have info in logs about
using version of ANE.

## Tapdaq
[Tapdaq Android SDK version 5.9.1](https://github.com/tapdaq/tapdaq-android-sdk)
[Tapdaq iOS SDK version 5.9.2](https://github.com/tapdaq/tapdaq-ios-sdk)

https://tapdaq.com/docs

on iOS version we need to remove all bash scripts from framework!!!

## Receptiv
Receptiv Android SDK 1.8.0
Receptiv iOS SDK 1.8.2

I couldn't find any link to it!!!Please help!
## MoPub
MoPub Android SDK 4.18
https://github.com/mopub/mopub-android-sdk

MoPub iOS SDK 4.16
https://github.com/mopub/mopub-ios-sdk

iOS version has different resources we need to put them into project's resources folder.
Also MoPub has MRAID file, do we need to integrate it somehow?

## Google
 Android only ANE required only if android project has no GPS as already added dependency.

## AdMob
AdMob iOS SDK 7.24.1

## Chartboost
Chartboost Android SDK 6.6.3
Chartboost iOS SDK 7.0.1

https://answers.chartboost.com/en-us/articles/download

## Applovin
AppLovin Android SDK 7.2.0
AppLovin iOS SDK 4.3.1

https://www.applovin.com/integration#iosIntegration

## Adcolony
Adcolony Android SDK 3.2.1
Adcolony iOS SDK 3.2.1

https://github.com/AdColony/

## HyperMX
HyperMX iOS SDK 7.3

https://documentation.hyprmx.com

## InMobi
InMobi Android SDK 7.0.0
InMobi iOS SDK 7.0.1

http://inmobi.com/sdk

## IronSource
IronSource Android SDK 6.6.8.1
IronSource iOS SDK 6.6.8.1

http://developers.ironsrc.com

## UnityAds
UnityAds Android SDK 2.1.0
UnityAds iOS SDK 2.1.1

https://github.com/Unity-Technologies/unity-ads-ios

## Vungle
Vungle Android SDK 5.1.0
Vungle iOS SDK 5.3.0

https://dashboard.vungle.com/sdk

## Tapjoy
Tapjoy Android SDK 11.11.0
Tapjoy iOS SDK 11.11.0

https://dev.tapjoy.com/sdk-integration/

It has Google Play Services as dependency and also show have additional assets for Android platform.
https://dev.tapjoy.com/sdk-integration/android/

Tapjoy has resources bundled into JAR file, so we need to extract them and put into res folder. Code for loading these
additional resources is bundled into ANE ( Init function for android platform).

It has specific way to init in the app and uses Gradle build system.

For iOS platform we need to remove resources bundles from frameworks (sdk and adapters in ane and project/app adapter) and put them into resources directory (for project it should be in resources folder not Frameworks!)!

## Facebook
Facebook Android SDK 4.25.0
Facebook Android SDK 4.25.0

https://developers.facebook.com/docs/audience-network

## How to update to the new version of Tapdaq SDK

Need to update EVERY project with new Adapter Frameworks and Jars and new newtworks SDKs for every android project. Please
make sure some adapters require to remove some stuff from it (tapdaq,tapjoy ios ).

After done call ant from the root project directory. When ant is finished without errors you can find
ANEs in `bin/anes`
and frameworks in `bin/resources/Frameworks`


## How to build

 You should have ANT 1.8 or greater, Adobe Air, Android SDK, xCode with build tools installed.

   Change required settings in common-build.properties file:
 * air.sdk = Path to `bin` dir of Adobe Air installation

 * android.sdk = Path to `home` dir of Android SDK installation

 Ant script could work with environment variables. Just setup AIR_SDK and ANDROID_SDK and ant script will skip local values.

 To build single ANE just enter the directory and run `ant` command.

 or run `ant` from root directory it will create bin\ folder with all anes and Frameworks.


 ### iOS build problems

  New Tapdaq Framework ( starting from 5.3.0) is built as shared library so we need to include it in the target ANE to get available on runtime! All adapters are now shared libraries so we need to include them into every ANE!
 Some of Frameworks are missed from Adobe Air  so we need to copy them from XCode to Air SDK ( stub folder)!
 So every platform has frameworks and sharedframeworks directories. If it's a static framework - put it into frameworks,
 adapters and other shared frameworks put into `sharedframeworks` folder. Add them both into platform.xml file and add as a resource to the target application.

 Adobe Air SDK 27 is required to build and properly sign iOS projects. Some frameworks might be missed from Adobe Air SDK 27 (FileProvider, IOSurface etc...) so you need to copy them from iOS SDK to Adobe Air SDK manually ( see more info in tapdaq-air-sdk-wiki).

## How to test

Open example project in Intellij IDEA, build all ANEs.
 Sample application is located in `sample` folder. Before test build the whole project and move ANEs into `anes` folder of sample application and frameworks into `resources\Frameworks`. Make sure you're using the correct provisioning profile/certificate when testing.


## Know issues

 * ApplicationVerificateFailed issue on iOS platform means application was signed with wrong certificate/provisioning or has wrong/missed frameworks within it. Please make sure you have added all required Frameworks/resources to target application.

 Error java.lang.OutOfMemoryError: GC overhead limit exceeded. This error appears while packing Android library. Increase the memory allocated for Java and the Adobe Air/Flex framework. Open jvm.config at $AIR_BASE_DIR/bin and set java.args with the line java.args=-Xmx1024m -Xms512m -Dsun.io.useCanonCaches=false instead of what is there. (-Xmx sets the max ram allocated for the Java runtime, and -Xms is the minimum.)

## How to start with new ANE

 Copy any of existing ANE directory.
 - Change actionscript related settings : actionscript/build.config, package name ( don't forget Stub.as file!).
 - Change android related settings : android/build.config, package name ( don't forget Extension and Context files!).
 - Change ios related settings : ios/build.config, ios project name/content, don't forget to add Framework to app Frameworks directory
 - Change ANE related settings : build.config and extension.xml files.
