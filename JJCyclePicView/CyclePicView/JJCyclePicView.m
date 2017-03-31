//
//  JJCyclePicView.m
//  JJCyclePicView
//
//  Created by 罗文琦 on 2017/3/31.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJCyclePicView.h"
#import "NSTimer+JJTimer.h"
#import "UIImageView+WebCache.h"
#define vMinPhoneWidth 320.0f
#define vWidthRatio CGRectGetWidth([UIScreen mainScreen].bounds)/vMinPhoneWidth

@interface JJCyclePicView ()<UITableViewDataSource, UITableViewDelegate>
{
    NSTimeInterval _animationDuration;
}


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSTimer *timer;


@end


@implementation JJCyclePicView

#pragma mark - 设置动画
- (void)setAnimationDuration:(NSTimeInterval)newDuration {
    _animationDuration = newDuration;
    if (([_dataArray count]>1)){
        if ([_timer isValid])[_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:_animationDuration
                                                  target:self
                                                selector:@selector(tableViewAutomaticScroll)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

#pragma mark - 位置
- (CGRect)calculateRect:(CGRect)original{
    CGRect rect = original;
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    rect.size = CGSizeMake(width, original.size.height*vWidthRatio);
    return rect;
}


- (instancetype)initWithMinFrame:(CGRect)frame {
    CGRect resizeRect = [self calculateRect:frame];
    self = [self initWithFrame:resizeRect];
    if (self) {}
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        if (!_dataArray) {
            [self setDataArray:[NSMutableArray new]];
        }
    }
    return self;
}


- (void)initializationUIWithDataArray:(NSArray *)dataArray {
    @autoreleasepool {
        
        [_dataArray removeAllObjects];
        if (!dataArray || [dataArray count] != 0) {
            if ([dataArray count]==1) {
                [_dataArray addObjectsFromArray:dataArray];
            }else{
                [_dataArray addObject:[dataArray objectAtIndex:[dataArray count]-1]];
                [_dataArray addObjectsFromArray:dataArray];
                [_dataArray addObject:[dataArray objectAtIndex:0]];
            }
        }else {
            [_dataArray addObject:@{@"user_bannerimg_str":@"default_banner"}];
        }
        
        //initialize AnimationDuration
        if (_animationDuration == 0.0000f) _animationDuration = 2.0f;
        
        if (!_tableView) {
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds];
            [tableView setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
            [tableView setFrame:self.bounds];
            [tableView setBounces:NO];
            [tableView setShowsHorizontalScrollIndicator:NO];
            [tableView setShowsVerticalScrollIndicator:NO];
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            [tableView setRowHeight:CGRectGetWidth(self.bounds)];
            [tableView setDelegate:self];
            [tableView setPagingEnabled:YES];
            [tableView setDataSource:self];
            [tableView setContentOffset:CGPointMake(0.0f, CGRectGetWidth(self.bounds))];
            [self setTableView:tableView];
            [self addSubview:tableView];
            tableView = nil;
        }
        
        if (!_pageControl) {
            CGRect pcRect = self.bounds;
            pcRect.size.height = 50.0f*vWidthRatio;
            pcRect.origin = CGPointMake(0.0f, CGRectGetHeight(self.bounds)-CGRectGetHeight(pcRect));
            UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:pcRect];
            [pageControl setUserInteractionEnabled:NO];
            [pageControl setPageIndicatorTintColor:[UIColor colorWithRed:0.824f green:0.827f blue:0.827f alpha:1.00f]];
            [pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
            [self setPageControl:pageControl];
            [self addSubview:pageControl];
            pageControl = nil;
        }
        
        if ([_dataArray count] >1) {
            NSInteger numberOfPages = ([_dataArray count] == 1)?1:[_dataArray count]-2;
            [_pageControl setNumberOfPages:numberOfPages];
            [_pageControl setCurrentPage:0];
            [_tableView reloadData];
            if ([_timer isValid])[_timer invalidate];
            _timer = [NSTimer scheduledTimerWithTimeInterval:_animationDuration
                                                      target:self
                                                    selector:@selector(tableViewAutomaticScroll)
                                                    userInfo:nil
                                                     repeats:YES];
        }
    }
    
}

#pragma -makr tableView scroll By automatic
- (void)tableViewAutomaticScroll{
    if ([_dataArray count] >1) {
        [_tableView setContentOffset:CGPointMake(_tableView.contentOffset.x, _tableView.contentOffset.y+CGRectGetWidth(self.bounds)) animated:YES];
    }
}


#pragma mark - 实现数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:[UIColor blackColor]];
        [cell setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [imageView setTag:9090];
        [cell addSubview:imageView];
        
    }
    // Configure the cell...
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:9090];
    [imageView setImage:nil];
    NSString *urlString = _dataArray[indexPath.row];
    
    if ([urlString rangeOfString:@"http"].location == NSNotFound) {
        //        [imageView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:urlString ofType:@"png"]]];
        [imageView setImage:[UIImage imageNamed:urlString]];
    }else {
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:urlString ofType:@"jpg"]]];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGRectGetWidth(self.bounds);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%@",_dataArray[indexPath.row]);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([_dataArray count] != 1) {
        [_timer pauseTimer];
        [scrollView setUserInteractionEnabled:NO];
    }
}

- (void)checkContentOffset:(UIScrollView *)scrollView {
    if ([_dataArray count] != 1) {
        NSInteger currentPage = scrollView.contentOffset.y/CGRectGetHeight(scrollView.bounds);
        currentPage -= 1;
        if (currentPage == [_dataArray count]-2) {
            [scrollView setContentOffset:CGPointMake(0.0f, CGRectGetWidth(self.bounds))];
            currentPage = 0;
        }
        if (currentPage == -1) {
            [scrollView setContentOffset:CGPointMake(0.0f, CGRectGetWidth(self.bounds) * ([_dataArray count]-2))];
            currentPage = [_dataArray count]-2;
        }
        [_pageControl setCurrentPage:currentPage];
        [scrollView setUserInteractionEnabled:YES];
    }
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self checkContentOffset:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self checkContentOffset:scrollView];
    if ([_timer isValid]&&[_dataArray count] != 1)[_timer resumeTimerAfterTimeInterval:_animationDuration];
}


@end
