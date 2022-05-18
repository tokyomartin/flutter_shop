#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"


@import Firebase; //增加FireBase支持

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  [FIRApp configure]; //增加FireBase支持

  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
