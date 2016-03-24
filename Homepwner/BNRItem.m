//
//  BNRItem.m
//  Homepwner
//
//  Created by hello on 16/2/22.
//  Copyright © 2016年 hello. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

-(void) setItemName:(NSString *)str
{
    _itemName = str;
}
-(NSString *)itemName
{
    return _itemName;
}

-(void)setSerialNumber:(NSString *)str
{
    _serialNumber = str;
}
-(NSString *)serialNumber
{
    return _serialNumber;
}

-(void)setValueInDollars:(int) v
{
    _valueInDollars = v;
}

-(int)valueInDollars
{
    return _valueInDollars;
}

-(NSDate *)dateCreated
{
    return _dateCreated;
}

-(instancetype)initWithItemName:(NSString *)name
                 valueInDollars:(int)value
                   serialNumber:(NSString *)sNumber
{
    self = [super init];
    
    if (self) {
        _itemName = name;
        _valueInDollars = value;
        _serialNumber = sNumber;
        
        _dateCreated = [[NSDate alloc] init];
        
        
        //创建一个NSUUID对象，然后获取其NSString类型的数值
        NSUUID *uuid = [[NSUUID alloc] init];
        NSString *key = [uuid UUIDString];
        _itemKey = key;
    }
    
    return self;
}

-(instancetype) initWithItemName:(NSString *)name
{
    return [self initWithItemName:name
                   valueInDollars:0
                     serialNumber:@""];
}

-(instancetype) init
{
    return [self initWithItemName:@"Item"];
}

+(instancetype)randomItem
{
    NSArray *randomAdjectiveList = @[@"Fluffy", @123, @"Shiny"];
    NSArray *randomNoumList = @[@"Bear", @"spork", @"Mac"];
    
    NSInteger adjectiveindex = arc4random() % [randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNoumList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@%@", [randomAdjectiveList objectAtIndex:adjectiveindex], [randomNoumList objectAtIndex:nounIndex]];
    
    int randomValue = arc4random() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10,
                                    'A' + arc4random() % 26,
                                    '0' + arc4random() % 10];
    
    BNRItem *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return newItem;
}

@end
