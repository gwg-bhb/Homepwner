//
//  BNRImageStore.h
//  Homepwner
//
//  Created by hello on 16/3/16.
//  Copyright © 2016年 hello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BNRImageStore : NSObject

+(instancetype)sharedStore;

-(void)setImage:(UIImage *)image forkey:(NSString *)key;
-(UIImage *)imageForKey:(NSString *)key;
-(void)deleteImageForKey:(NSString *)key;


@end
