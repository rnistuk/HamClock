//
//  OperatorsManager.h
//  HamClock
//
//  Created by Rich Nistuk on 2021-04-20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OperatorsManager : NSObject

-(instancetype)initWithFileName:(NSString*)operatorsFileName;

// crud
-(bool)createOperatorWithHandle:(NSString*)handle
                           name:(NSString*)name
                       location:(NSString*)location
                           note:(NSString*)note;

-(void)createDateForOperatorWithHandle:(NSString*)handle;

-(NSArray*)readOperatorsWithHandleSuffix:(NSString*)suffix;

-(void)updateOperatorWithHandle:(NSString*)handle
                           name:(NSString*)name
                       location:(NSString*)location
                           note:(NSString*)note;

-(void)deleteOperatorWithHandle:(NSString*)handle;

-(void)deleteDateForOperatorWithHandle:(NSString*)handle ;


@end

NS_ASSUME_NONNULL_END
