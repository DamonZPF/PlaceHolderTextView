//
//  EmotionTabbarView.h
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/25.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    EmotionTabbarButtonTypeRecent, //最近
    EmotionTabbarButtonTypeDefault, //默认
    EmotionTabbarButtonTypeEmoji, //EMoji
    EmotionTabbarButtonTypeLxh, //浪小花
    
}EmotionTabbarButtonType;
@interface EmotionTabbarView : UIView
@property(nonatomic,assign)EmotionTabbarButtonType  buttonType;
@property(nonatomic,copy)void (^didSelectBtnBlock)(EmotionTabbarView * emotionTabbarView ,EmotionTabbarButtonType buttonType);
@end
