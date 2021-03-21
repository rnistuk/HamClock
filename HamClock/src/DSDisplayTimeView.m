#import "DSDisplayTimeView.h"

@implementation DSDisplayTimeView


-(id) initWithCoder:(NSCoder *)coder {
    if(self = [super initWithCoder:coder]) {
        [NSTimer scheduledTimerWithTimeInterval:0.1
                                         target:self
                                         selector:@selector(updateTime)
                                         userInfo:nil
                                         repeats:YES];
        
    }
    return self;
}

-(void) awakeFromNib {
    self.wantsLayer = YES;
}

-(BOOL) wantsUpdateLayer {
    return YES;
}


- (void)updateLayer {
   self.layer.backgroundColor = [NSColor colorWithCalibratedRed:0.000f
                                                          green:0.000f
                                                           blue:0.000f
                                                          alpha:1.0].CGColor;
}


- (void) updateTime {
    NSDate* dateNow = [NSDate now];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setDateStyle:NSDateFormatterNoStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    
    [self.localTimeTextField setStringValue:[df stringFromDate:dateNow]];
    
    
    [df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [self.utcTimeTextField setStringValue:[df stringFromDate:dateNow]];
    
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
