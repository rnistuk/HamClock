#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface OperatorsTableViewController : NSObject <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) NSDictionary *operators;

@end

NS_ASSUME_NONNULL_END
