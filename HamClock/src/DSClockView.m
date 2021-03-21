#import "DSClockView.h"

@implementation DSClockView {
    NSCalendar* gregorian;
}

-(id) init {
    if (self = [super init]) {
        NSLog(@"init");
    }
    return self;
}

-(id) initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        NSLog(@"initWithFrame");
    }
    return self;
}


-(id) initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        gregorian = [NSCalendar currentCalendar];
        [NSTimer scheduledTimerWithTimeInterval:0.05
                                         target:self
                                         selector:@selector(redraw)
                                         userInfo:nil
                                         repeats:YES];
    }
    return self;
}

-(void) redraw {
    [self setNeedsDisplay:YES];
}

-(NSPoint) centerOfViewBound{
    NSPoint origin = self.bounds.origin;
    NSSize size = self.bounds.size;
    return NSMakePoint(origin.x + size.width / 2.0, origin.y + size.height / 2.0);
}

-(void) drawHandAtAngle:(CGFloat)angle withLength:(CGFloat)length {
    NSPoint center = [self centerOfViewBound];
    NSPoint handEnd = NSMakePoint(center.x + length * cos(-angle), center.y + length * sin(-angle));
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path setLineWidth:2];
    [path moveToPoint:center];
    [path lineToPoint:handEnd];
    [[NSColor greenColor] setStroke];
    [path stroke];
}

-(void) drawSecondHand:(CGFloat)seconds {
    CGFloat length = 0.90 * MIN(self.bounds.size.width, self.bounds.size.height) / 2.0;
    CGFloat angle = (2.0 * M_PI * seconds / 60.0) - M_PI_2;
    [self drawHandAtAngle:angle withLength:length];
}

- (void) drawMinuteHand:(CGFloat)minutes {
    CGFloat length = 0.75 * MIN(self.bounds.size.width, self.bounds.size.height) / 2.0;
    CGFloat angle = (2.0 * M_PI * minutes / 60.0) - M_PI_2;
    [self drawHandAtAngle:angle withLength:length];
}

- (void) drawHourHand:(CGFloat)hours {
    CGFloat length = 0.50 * MIN(self.bounds.size.width, self.bounds.size.height) / 2.0;
    CGFloat angle = (2.0 * M_PI * hours / 12.0) - M_PI_2;
    [self drawHandAtAngle:angle withLength:length];
}

- (NSDateComponents*) localDateComponents:(NSDate*)now {
    return [gregorian componentsInTimeZone:[NSTimeZone localTimeZone] fromDate:now];
}

- (NSDateComponents*) utcDateComponents:(NSDate*)now {
    return [gregorian componentsInTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0] fromDate:now];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSBezierPath* path = [NSBezierPath
                          bezierPathWithRect:self.bounds];
    [[NSColor blackColor] setFill];
    [path fill];
    [path stroke];
    
    
    
    
    NSImage* clockface = [NSImage imageNamed:@"clockface"];
    [clockface setSize:self.bounds.size];
    [clockface drawAtPoint:NSMakePoint(0,0)
                  fromRect:NSZeroRect
                 operation:NSCompositingOperationCopy
                  fraction:1.0];
    
    NSDateComponents* dateComponents = [self localDateComponents:[NSDate now]];
    CGFloat seconds = (dateComponents.second + dateComponents.nanosecond/1.0e9);
    CGFloat minutes = dateComponents.minute + seconds / 60.0;
    CGFloat hours = dateComponents.hour % 12 + minutes / 60.0;
    
    
    [self drawSecondHand:seconds];
    [self drawMinuteHand:minutes];
    [self drawHourHand:hours];
}

@end
