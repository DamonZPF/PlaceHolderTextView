//
//  EmotionButton.m
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/30.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "EmotionButton.h"
#import "EmotionModel.h"
#import "NSString+Emoji.h"
@implementation EmotionButton

-(void)setEmotionModel:(EmotionModel *)emotionModel{
    _emotionModel = emotionModel;
    
    if (emotionModel.png.length !=0) {
        [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",emotionModel.png]] forState:UIControlStateNormal];
    }else if (emotionModel.code.length != 0){
        [self setTitle:emotionModel.code.emoji forState:UIControlStateNormal];
    }
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
          [self setup];
    }
    return self;
}

-(void)setup{
    self.adjustsImageWhenHighlighted = NO;
    self.titleLabel.font = [UIFont systemFontOfSize:32];
}

@end
