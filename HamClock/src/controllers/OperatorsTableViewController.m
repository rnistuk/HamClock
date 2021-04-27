//
//  ParticipantsTableViewController.m
//  HamClock
//
//  Created by Rich Nistuk on 2021-04-14.
//

#import "OperatorsTableViewController.h"

@interface OperatorsTableViewController ()
@property (nonatomic, strong) NSDictionary* columnHandlers;
@end

@implementation OperatorsTableViewController

-(instancetype)init {
    self = [super init];
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        self.columnHandlers = @{
            @"handles":^(NSTableCellView* cell, NSString* handle){
                cell.textField.stringValue = handle;
            },
            @"names":^(NSTableCellView* cell, NSString* handle){
                id name = [self.operators valueForKey:handle];
                cell.textField.stringValue = name;
            },
            @"locations":^(NSTableCellView* cell, NSString* handle){
                //id name = [self.operators valueForKey:handle];
                cell.textField.stringValue = @"location";
            },
        };
    });
    
    return self;
}

- (NSArray*)splitHandle:(NSString*)handle {
    return [handle componentsSeparatedByCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
}

- (NSDictionary *) operators {
    if (!_operators) {
        _operators = @{@"VA7RHN":@"Rich", @"VE7CTH":@"Brian", @"VA7QU":@"Don", @"VE7IAI":@"John", @"VE7CGE":@"Lou"};
        _handles = [[_operators allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSArray* c1 = [self splitHandle:obj1];
            NSArray* c2 = [self splitHandle:obj2];
            return [c1.lastObject compare:c2.lastObject];
        }];
    }
    return _operators;
}

// NSTableViewDatasource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.operators.count;
}




// NSTableViewDelegate
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = tableColumn.identifier;
    NSTableCellView *cell = [tableView makeViewWithIdentifier:identifier owner:self];
    
    id handle = [self.handles objectAtIndex:row];
    void(^block)(NSTableCellView* cell, NSString* handle) = [self.columnHandlers objectForKey:identifier];
    if (block != nil)
    {
        block(cell, handle);
        return cell;
    }
    NSLog(@"\n\n[%@]\n", cell.identifier);
    
    
    return cell;
}

@end
