#import "CMDDevPageController.h"

@implementation CMDDevPageController

- (NSMutableArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Developer" target:self];
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
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/dev.quiprr.cmdlooper.plist"];
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
    }
    [dict setObject:value forKey:[specifier propertyForKey:@"key"]];
    [dict writeToFile:@"/var/mobile/Library/Preferences/dev.quiprr.cmdlooper.plist" atomically:YES];
}

- (void)openGitHub
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/quiprr/cmdLooper"] options:@{} completionHandler:nil];
}

- (void)openTwitter
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/quiprr"] options:@{} completionHandler:nil];
}

- (void)openWebsite
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://quiprr.dev/"] options:@{} completionHandler:nil];
}

- (void)openReddit
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://reddit.com/u/quiprr"] options:@{} completionHandler:nil];
}

- (void)openPayPal
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/quiprr"] options:@{} completionHandler:nil];
}

- (void)openDiscord
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://discord.gg/Wy4K2gQ"] options:@{} completionHandler:nil];
}

- (void)specialThanks
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Special Thanks"
                           message:@"@CaptInc - Lots of NotiPing base code\n@A1Matrix - Idea"
                           preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                               handler:nil];

        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
}

@end
