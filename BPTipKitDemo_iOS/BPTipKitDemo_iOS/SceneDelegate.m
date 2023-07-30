//
//  SceneDelegate.m
//  BPTipKitDemo_iOS
//
//  Created by Jinwoo Kim on 7/29/23.
//

#import "SceneDelegate.h"
#import "ViewController.h"

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    UIWindow *window = [[UIWindow alloc] initWithWindowScene:windowScene];
    ViewController *rootViewController = [ViewController new];
    window.rootViewController = rootViewController;
    [window makeKeyAndVisible];
    self.window = window;
}

@end
