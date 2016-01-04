//
//  EmotionPageView.m
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/26.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "EmotionPageView.h"
#import "EmotionModel.h"
#import "NSString+Emoji.h"
#import "EmotionPopView.h"
#import "UIView+Extension.h"
#import "EmotionButton.h"
#define EmotionMaxRows 3
#define EMotionMaxCols 7

@interface EmotionPageView()
@property(nonatomic,strong)EmotionPopView * popView;
@end
@implementation EmotionPageView

-(EmotionPopView*)popView{
    if (_popView == nil) {
        _popView = [EmotionPopView emotionPopView];
    }
    return _popView;
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    
    CGFloat W = self.bounds.size.width / EMotionMaxCols;
    CGFloat H = self.bounds.size.height / EmotionMaxRows;
    for (NSInteger index = 0; index < emotions.count; index++) {
        EmotionButton * button = [[EmotionButton alloc] init];
        EmotionModel * model =emotions[index];
        CGFloat X = (index % EMotionMaxCols) * W;
        CGFloat Y = (index / EMotionMaxCols) * H ;
        button.emotionModel = model;
        
        button.frame = CGRectMake(X, Y, W, H);
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

-(void)clickButton:(EmotionButton*)button{
    UIWindow * window =  [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.popView];
    EmotionModel * model = button.emotionModel;
    self.popView.emotionButton.emotionModel = model;

    CGRect frame = [button convertRect:button.bounds toView:nil];
    self.popView.centerX = CGRectGetMidX(frame);
    self.popView.y = CGRectGetMidY(frame) - self.popView.height;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
   
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"EmotionNameModelKey"] = model;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmotionNameModelKey" object:nil userInfo:dict];
    
}

@end
