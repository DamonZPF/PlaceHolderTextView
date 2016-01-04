//
//  EmotionModel.m
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/25.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "EmotionModel.h"

@implementation EmotionModel
-(instancetype)initWithDictionary:(NSDictionary*)dict{
    self =[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(NSArray*)getDataWithArray:(NSArray*)datas{

    NSMutableArray * mutiArray = [NSMutableArray array];
    for (NSDictionary * dict in datas) {
        [mutiArray addObject:  [[self alloc] initWithDictionary:dict]];
    
    }

    return mutiArray;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@", self.chs,self.png,self.code,self.chs];
}

@end
