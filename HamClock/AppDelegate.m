#import "AppDelegate.h"
#import "DSClockView.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;
@property (strong) NSView *clockView;
@end

@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self.clockView autoresizesSubviews];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
