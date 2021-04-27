//
//  OperatorsManager.m
//  HamClock
//
//  Created by Rich Nistuk on 2021-04-20.
//

#import "OperatorsManager.h"

@interface OperatorsManager ()
@property (nonatomic, strong) NSArray* headers;
@property (nonatomic, strong) NSMutableDictionary* operators;
@end

@implementation OperatorsManager

//NSString* resourcePath = [NSString stringWithFormat:@"%@/operators.csv",[[NSBundle mainBundle] resourcePath]];
-(instancetype)initWithFileName:(NSString*)operatorsFileName {
    self = [super init];
    
    
    return self;
}

-(NSArray*)parseLinesInText:(NSString*)text {
    return [text componentsSeparatedByString:@"\n"];
}

-(NSString*)readOperatorsFile:(NSString*) filePath {
    return  [NSString stringWithContentsOfFile:filePath
                                      encoding:NSUTF8StringEncoding
                                         error:nil];
}

- (NSDictionary*) loadOperatorsFromText:(NSString*)text {
    //NSString* operatorsText = [self readOperatorsFile];
    id lines = [self parseLinesInText:text];
    
    __block NSArray* headers;
    __block NSMutableDictionary* operators = [NSMutableDictionary new];
    
    [lines enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj length]) {
            id values = [obj componentsSeparatedByString:@"|"];
            
            if (0 == idx) {
                headers = values;
                return;
            }
            
            // TODO move that next chunk into a method to be used in the setValue above...
            id handle = values[0];
            
            __block NSMutableDictionary* operator = [NSMutableDictionary new];
            __block NSMutableArray* checkins = [NSMutableArray new];
            [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ( 0 < [headers[idx] length]) {
                    if (idx < 6 ) {
                        [operator setValue:obj forKey:headers[idx]];
                        return;
                    }
                    if ([obj isEqual:@"1"])
                    {
                        [checkins addObject:headers[idx]];
                        return;
                    }
                }
            }];
            [operator setValue:checkins forKey:@"checkins"];
            [operators setValue:operator forKey:handle];
        }
    }];
    return operators;
}

// crud
-(bool)createOperatorWithHandle:(NSString*)handle
                           name:(NSString*)name
                       location:(NSString*)location
                           note:(NSString*)note {
    //if(self.)
    return NO;
}

-(void)createDateForOperators:(NSString*)date {
    
}

-(void)createDateForOperatorWithHandle:(NSString*)handle {
    
}

-(NSArray*)readOperatorsWithHandleSuffix:(NSString*)suffix {
    return nil;
}

-(void)updateOperatorWithHandle:(NSString*)handle
                           name:(NSString*)name
                       location:(NSString*)location
                           note:(NSString*)note {
}

-(void)deleteOperatorWithHandle:(NSString*)handle{
}

-(void)deleteDateForOperatorWithHandle:(NSString*)handle {
}
    





@end
