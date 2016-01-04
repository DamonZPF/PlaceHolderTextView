//
//  EmotionListView.m
//  PlaceHolderTextView
//
//  Created by Duomai on 15/11/25.
//  Copyright © 2015年 zpf. All rights reserved.
//

#import "EmotionListView.h"
#import "EmotionModel.h"
#import "EmotionPageView.h"
#define KPageControllHeight 18
#define KEmotionNumberPage 20

@interface EmotionListView()<UIScrollViewDelegate>

@property(nonatomic,weak)UIScrollView * scrollView ;
@property(nonatomic,weak)UIPageControl * pageControl;

@end

@implementation EmotionListView

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView * scrollView  = [[UIScrollView alloc] init];
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl * pageControl = [[UIPageControl alloc] init];
        pageControl.backgroundColor = [UIColor clearColor];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    self.pageControl.numberOfPages = (emotions.count + KEmotionNumberPage - 1) / KEmotionNumberPage;
    
    CGFloat x = 0;
    for (NSInteger index = 0; index < self.pageControl.numberOfPages; index++) {
        EmotionPageView * pageView = [[EmotionPageView alloc] init];
        pageView.frame = CGRectMake(x, 0, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height- KPageControllHeight);
        
        NSRange range ;
        range.location = index * KEmotionNumberPage;
        NSInteger length =  emotions.count - range.location;
        if (length >= KEmotionNumberPage) {
             range.length = KEmotionNumberPage;
        }else{
            range.length = length;
        }
       
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
        x += [UIScreen mainScreen].bounds.size.width;
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake(self.pageControl.numberOfPages * [UIScreen mainScreen].bounds.size.width, 0);
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height - KPageControllHeight);
    self.pageControl.frame = CGRectMake(0, self.bounds.size.height - KPageControllHeight,[UIScreen mainScreen].bounds.size.width, KPageControllHeight);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width + 0.5) ;
    self.pageControl.currentPage = page;
}

@end
