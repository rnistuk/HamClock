#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSDisplayTimeView : NSView
@property (weak) IBOutlet NSTextField *localTimeTextField;
@property (weak) IBOutlet NSTextField *utcTimeTextField;

@end

NS_ASSUME_NONNULL_END
