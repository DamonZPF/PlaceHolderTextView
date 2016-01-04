//
//  EmotionKeyboardView.m
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/25.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "EmotionKeyboardView.h"
#import "EmotionTabbarView.h"
#import "EmotionModel.h"
#import "EmotionListView.h"

#define kEmotionKeyBoardHeight 216
#define kEmotionTabbarHeight 37

@interface EmotionKeyboardView()

@property (weak, nonatomic) IBOutlet EmotionTabbarView *emotionTabbarView;

@property (weak, nonatomic) IBOutlet UIView *emotionBgView;

/** 表情内容 */
@property (nonatomic, strong) EmotionListView *recentListView;
@property (nonatomic, strong) EmotionListView *defaultListView;
@property (nonatomic, strong) EmotionListView *emojiListView;
@property (nonatomic, strong) EmotionListView *lxhListView;

@end

@implementation EmotionKeyboardView


#pragma mark - 懒加载
- (EmotionListView *)recentListView
{
    if (!_recentListView) {
        _recentListView = [[EmotionListView alloc] initWithFrame:self.emotionBgView.bounds];
       
    }
    return _recentListView;
}

- (EmotionListView *)defaultListView
{
    if (!_defaultListView) {
        _defaultListView = [[EmotionListView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, kEmotionKeyBoardHeight - kEmotionTabbarHeight)];
        
        
        //_defaultListView.backgroundColor = [UIColor redColor];
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"default/info" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        NSArray * contents =    [EmotionModel getDataWithArray:array];
        self.defaultListView.emotions = contents;
    }
    return _defaultListView;
}


- (EmotionListView *)emojiListView
{
    if (!_emojiListView) {
        _emojiListView = [[EmotionListView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kEmotionKeyBoardHeight - kEmotionTabbarHeight)];
       // _emojiListView.backgroundColor = [UIColor blueColor];
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"emoji/info" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
         NSArray * contents =    [EmotionModel getDataWithArray:array];
        self.emojiListView.emotions = contents;
    }
    return _emojiListView;
}

- (EmotionListView *)lxhListView
{
    if (!_lxhListView) {
        _lxhListView = [[EmotionListView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kEmotionKeyBoardHeight - kEmotionTabbarHeight)];
     //   _lxhListView.backgroundColor = [UIColor purpleColor];
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"lxh/info" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        NSArray * contents =    [EmotionModel getDataWithArray:array];
        self.lxhListView.emotions = contents;
    }
    return _lxhListView;
}


-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.emotionTabbarView.didSelectBtnBlock = ^(EmotionTabbarView * emotionTabbarView ,EmotionTabbarButtonType buttonType){
        //移除 emotionBgView 之前显示的控件
        [self.emotionBgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        switch (buttonType) {
            case EmotionTabbarButtonTypeRecent:{
                [self.emotionBgView addSubview:self.recentListView];
                break;
            }
            case EmotionTabbarButtonTypeDefault:{
                [self.emotionBgView addSubview:self.defaultListView];
                break;
            }
            case EmotionTabbarButtonTypeEmoji:{
                [self.emotionBgView addSubview:self.emojiListView];
                break;
            }
            case EmotionTabbarButtonTypeLxh:{
                [self.emotionBgView addSubview:self.lxhListView];
                break;
            }
            default:
                break;
        }
    };
    
  
    
}



+(EmotionKeyboardView*)emotionKeyboardView{

   return [[[NSBundle mainBundle] loadNibNamed:@"EmotionKeyboardView" owner:self options:nil] lastObject];
   
}

-(void)setFrame:(CGRect)frame{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.size.height = kEmotionKeyBoardHeight;
    [super setFrame:frame];
}

@end
