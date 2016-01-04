//
//  EmotionPopView.m
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/30.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "EmotionPopView.h"

@implementation EmotionPopView
+(instancetype)emotionPopView{

    return [[[NSBundle mainBundle]loadNibNamed:@"EmotionPopView" owner:nil options:nil]lastObject];
    
}

@end
