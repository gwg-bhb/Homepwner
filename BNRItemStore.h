//
//  BNRItemStore.h
//  Homepwner
//
//  Created by hello on 16/2/24.
//  Copyright © 2016年 hello. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;
@interface BNRItemStore : NSObject


+(instancetype) sharedStore;//类方法
-(BNRItem *)createItem;
-(NSArray *)allItems;
-(void)removeItem:(BNRItem *)item;
-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
@end
