#import "DSClockView.h"
#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (weak) IBOutlet DSClockView *clockview;
@property (strong, nonatomic) NSDictionary *operators;
@end
