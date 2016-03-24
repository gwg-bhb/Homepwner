//
//  BNRItem.h
//  Homepwner
//
//  Created by hello on 16/2/22.
//  Copyright © 2016年 hello. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject
{
    NSString *_itemName;
    NSString *_serialNumber;
    int _valueInDollars;
    NSDate *_dateCreated;
}
@property (nonatomic, copy) NSString *itemKey;

+(instancetype)randomItem;

-(instancetype)initWithItemName:(NSString *)name
                 valueInDollars:(int)value
                   serialNumber:(NSString *)sNumber;
-(instancetype)initWithItemName:(NSString *)name;
-(instancetype)init;

-(void) setItemName:(NSString *)str;
-(NSString *)itemName;

-(void)setSerialNumber:(NSString *)str;
-(NSString *)serialNumber;

-(void)setValueInDollars:(int) v;
-(int)valueInDollars;

-(NSDate *)dateCreated;

@end
