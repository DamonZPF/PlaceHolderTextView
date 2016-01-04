//
//  EmotionModel.h
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/25.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmotionModel : NSObject
@property (nonatomic,copy) NSString * chs;
@property (nonatomic,copy) NSString * png;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * cht;
@property (nonatomic,copy) NSString * gif;
@property (nonatomic,copy) NSString * type;

-(instancetype)initWithDictionary:(NSDictionary*)dict;
+(NSArray*)getDataWithArray:(NSArray*)datas;
@end
