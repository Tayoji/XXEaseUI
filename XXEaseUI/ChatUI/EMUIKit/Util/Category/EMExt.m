//
//  EMExt.m
//  supplier
//
//  Created by xiucheren on 16/8/1.
//  Copyright © 2016年 Tayoji. All rights reserved.
//

#import "EMExt.h"

@implementation EMExt
-(instancetype)initWithDict:(NSDictionary *)ext{
    self = [super init];
    if (ext){
        [self setValuesForKeysWithDictionary:ext];
    }
    return self;
}
-(void)setParams:(EMParams *)params{
    NSDictionary * dict = (NSDictionary *)params;
    _params = [[EMParams alloc] initWithDict:dict];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
-(id)valueForUndefinedKey:(NSString *)key{
    return  nil;
}

@end
