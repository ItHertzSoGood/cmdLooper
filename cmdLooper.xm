#import "NSTask.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SBIconController : UIViewController
- (void)executeCmd;
@end

BOOL wasTheTimerAdded = NO;
NSDictionary *cmdlPrefsDict;

%hook SBIconController
- (void)viewDidLoad {
    %orig;

    NSLog(@"cmdLooper: helo_world!");
    cmdlPrefsDict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/dev.quiprr.cmdlooper.plist"];
    BOOL shouldEnablecmdLooper = [[cmdlPrefsDict objectForKey:@"enableTweak"] boolValue];
    NSNumber *timerDelay = [cmdlPrefsDict objectForKey:@"timerDelay"];
    double putIntoNSTimer = [timerDelay doubleValue];
    NSLog(@"cmdLooper: putIntoNSTimer: %f", putIntoNSTimer);
    NSLog(@"cmdLooper: shouldEnablecmdLooper: %hhd", shouldEnablecmdLooper);

    if (shouldEnablecmdLooper) {
        if (!wasTheTimerAdded) {
            wasTheTimerAdded = YES;
            NSLog(@"cmdLooper: timer started");
            [NSTimer scheduledTimerWithTimeInterval:putIntoNSTimer target:self selector:@selector(executeCmd) userInfo:nil repeats:YES];
        }
    }
}

%new

- (void)executeCmd {

    NSLog(@"cmdLooper: executeCmd called!!!!");
    NSString *command = [cmdlPrefsDict objectForKey:@"command"];
    NSLog (@"cmdlooper: command: %@", command);
    NSTask *runCommand = [[NSTask alloc] init];
    runCommand.launchPath = command;
    [runCommand launch];

}
%end
