#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSTask.h"

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else 
#define NSLog(...) (void)0
#endif

@interface SBIconController : UIViewController
- (void)executeCmd;
@end
