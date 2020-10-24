#import "cmdLooper.h"

id readPreferenceValue(id key, id fallback)
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/dev.quiprr.cmdlooper.plist"];
    id value = [dict valueForKey:key] ? [dict valueForKey:key] : fallback; // This allows for a fallback value if the plist doesn't exist/doesn't have the value it's looking for
    NSLog(@"cmdLooper: readPreferenceValue: key: %@ value: %@", key, value);
    return value;
}

BOOL wasTheTimerAdded = NO;

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)args
{
    %orig;

    id enabled = readPreferenceValue(@"enableTweak", @"YES");
    id timerDelay = readPreferenceValue(@"timerDelay", @"60");
    double putIntoNSTimer = [timerDelay doubleValue];

    if (enabled) {
        if (!wasTheTimerAdded) {
            wasTheTimerAdded = YES;
            NSLog(@"cmdLooper: Timer started!");
            [NSTimer scheduledTimerWithTimeInterval:putIntoNSTimer target:self selector:@selector(executeCmd) userInfo:nil repeats:YES];
        }
    }
}

%new

- (void)executeCmd
{
    NSLog(@"cmdLooper: executeCmd called!");
    id command = readPreferenceValue(@"command", @"/usr/bin/sbreload");
    NSTask *runCommand = [[NSTask alloc] init];
    runCommand.launchPath = command;
    [runCommand launch];
}

%end
