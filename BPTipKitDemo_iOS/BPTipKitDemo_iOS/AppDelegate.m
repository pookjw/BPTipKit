//
//  AppDelegate.m
//  BPTipKitDemo_iOS
//
//  Created by Jinwoo Kim on 7/29/23.
//

#import "AppDelegate.h"
#import "SceneDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    UISceneConfiguration *configuration = connectingSceneSession.configuration;
    configuration.delegateClass = SceneDelegate.class;
    return configuration;
}

@end
