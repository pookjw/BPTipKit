//
//  ViewController.m
//  BPTipKitDemo_iOS
//
//  Created by Jinwoo Kim on 7/29/23.
//

#import "ViewController.h"
@import BPTipKit;

@interface Tip : NSObject <BPTip>
@end
@implementation Tip
- (NSAttributedString *)title {
    return [[NSAttributedString alloc] initWithString:@"Hello World!" attributes:@{NSForegroundColorAttributeName: UIColor.systemRedColor}];
}
- (NSArray<BPTipsAction *> *)actions {
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Foo!" attributes:@{NSForegroundColorAttributeName: UIColor.systemBrownColor}];
    
    BPTipsAction *firstAction = [[BPTipsAction alloc] initWithActionID:@"" title:title disabled:NO performHandler:^{
        NSLog(@"Hello!");
    }];
    
    return @[firstAction];
}
- (NSString *)tipID {
    return @"2";
}
- (NSArray<id<BPTipsRule>> *)rules {
    BPTipsParameterValue *defaultValue = [[BPTipsParameterValue alloc] initWithValue:@YES];
    BPTipsParameter *parameter = [[BPTipsParameter alloc] initWithDefaultValue:defaultValue key:@"key" isTransient:NO];
    parameter.parameterValue = [[BPTipsParameterValue alloc] initWithValue:@NO];
    NSLog(@"%@", parameter.parameterValue.value);
    
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    
    BPTipsParameterRule *rule = [[BPTipsParameterRule alloc] initWithParameter:parameter predicate:predicate];
    
    return @[rule];
}
@end

@interface ViewController ()
@property (strong) BPTipCancellable *cancellable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemCyanColor;
    
    NSArray<id<BPTipsConfiguration>> *configurations = @[
        BPDatastoreLocation.applicationDefaultDatastoreLocation,
        BPDisplayFrequency.immediateFrequency
    ];
    
    [BPTips configureWithConfigurations:configurations completionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@", error);
        
        [NSOperationQueue.mainQueue addOperationWithBlock:^{
            Tip *tip = [Tip new];
            BPTipStatus *status = [[BPTipStatus alloc] initWithBPTip:tip];
            
//            self.cancellable = [status observeStatusUpdatesWithHandler:^{
//                NSLog(@"isAvailable: %d, isInvalidated: %d, isPending: %d, shouldDisplay: %d", status.isAvailable, status.isInvalidated, status.isPending, status.shouldDisplay);
//            }];
            self.cancellable = [status observeShouldDisplayUpdatesWithHandler:^(BOOL newValue) {
                NSLog(@"%d", newValue);
            }];
            
            BPTipUIView *tipView = [[BPTipUIView alloc] initWithBPTip:tip arrowEdge:NSDirectionalRectEdgeLeading actionHandler:^(BPTipsAction * _Nonnull action) {
                NSLog(@"%@", action);
            }];
            
            tipView.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addSubview:tipView];
            [NSLayoutConstraint activateConstraints:@[
                [tipView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                [tipView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                [tipView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
            ]];
        }];
    }];
}

@end
