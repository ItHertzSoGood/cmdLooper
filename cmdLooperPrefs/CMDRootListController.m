#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CMDRootListController.h"
#import "NSTask.h"

@implementation CMDRootListController

- (NSMutableArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }
    return _specifiers;
}

- (id)readPreferenceValue:(PSSpecifier *)specifier {
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/dev.quiprr.cmdlooper.plist"];
    id object = [dict objectForKey:[specifier propertyForKey:@"key"]];
    if (!object) {
        object = [specifier propertyForKey:@"default"];
    }
    return object;
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/dev.quiprr.cmdLooper.plist"];
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
    }
    [dict setObject:value forKey:[specifier propertyForKey:@"key"]];
    [dict writeToFile:@"/var/mobile/Library/Preferences/dev.quiprr.cmdlooper.plist" atomically:YES];
}

-(void)sbreload
{
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"cmdLooper"
							message:@"Your settings have been applied.\n Would you like to respring to activate now?"
							preferredStyle:UIAlertControllerStyleActionSheet];

		UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel
		handler:^(UIAlertAction * action) {}];
		UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive
		handler:^(UIAlertAction * action) {
			NSTask *t = [[NSTask alloc] init];
			[t setLaunchPath:@"usr/bin/sbreload"];
			[t launch];
		}];

		[alert addAction:defaultAction];
		[alert addAction:yes];
		[self presentViewController:alert animated:YES completion:nil];

}

@end
