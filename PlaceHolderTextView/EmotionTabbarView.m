//
//  EmotionTabbarView.m
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/25.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "EmotionTabbarView.h"
@interface EmotionTabbarView()
@property(nonatomic,strong)UIButton * selectedBtn;
@end


@implementation EmotionTabbarView
-(void)awakeFromNib{

    [self setupBtn:@"最近" withButtonType:EmotionTabbarButtonTypeRecent];
    UIButton * defaultBtn = [self setupBtn:@"默认" withButtonType:EmotionTabbarButtonTypeDefault];
    [self setupBtn:@"Emoji" withButtonType:EmotionTabbarButtonTypeEmoji];
    [self setupBtn:@"浪小花" withButtonType:EmotionTabbarButtonTypeLxh];
    
    [self clickBtn:defaultBtn];
}

-(UIButton* )setupBtn:(NSString*)title withButtonType:(EmotionTabbarButtonType)buttonType{

    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = buttonType;
    btn.adjustsImageWhenDisabled = NO;
    btn.adjustsImageWhenHighlighted = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
      [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
        UIImage * normalImage = nil;
        UIImage * selectedImage = nil;
        if (self.subviews.count == 1) {
            normalImage = [UIImage imageNamed:@"compose_emotion_table_left_normal"];
            selectedImage = [UIImage imageNamed:@"compose_emotion_table_left_selected"];
        }else if (self.subviews.count == 4){
            normalImage = [UIImage imageNamed:@"compose_emotion_table_right_normal"];
            selectedImage = [UIImage imageNamed:@"compose_emotion_table_right_selected"];
        }else{
            normalImage = [UIImage imageNamed:@"compose_emotion_table_mid_normal"];
            selectedImage = [UIImage imageNamed:@"compose_emotion_table_mid_selected"];
        }

    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:selectedImage forState:UIControlStateDisabled];
    return btn;
}

-(void)clickBtn:(UIButton*)btn{
    
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    if (self.didSelectBtnBlock) {
        self.didSelectBtnBlock(self,btn.tag);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.bounds.size.width / btnCount;
    CGFloat btnH = self.bounds.size.height;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat y = 0;
        CGFloat width = btnW;
        CGFloat x = i * btnW;
        CGFloat height = btnH;
        btn.frame = CGRectMake(x, y, width, height);
        
    }
}
@end
