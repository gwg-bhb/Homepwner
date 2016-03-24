//
//  BNRImageStore.m
//  Homepwner
//
//  Created by hello on 16/3/16.
//  Copyright © 2016年 hello. All rights reserved.
//

#import "BNRImageStore.h"


@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;
@end

@implementation BNRImageStore

+(instancetype)sharedStore
{
    static BNRImageStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use+[BNRImageStore sharedStore]" userInfo:nil];
    
    return nil;
}

-(instancetype)initPrivate
{
    self = [super init];
    
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)setImage:(UIImage *)image forkey:(NSString *)key
{
//    [self.dictionary setObject:image forKey:key];
    self.dictionary[key] = image;
}

-(UIImage *)imageForKey:(NSString *)key
{
//    return  [self.dictionary objectForKey:key];
    return self.dictionary[key];
}

-(void)deleteImageForKey:(NSString *)key
{
    [self.dictionary removeObjectForKey:key];
}
@end
