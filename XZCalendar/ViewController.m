//
//  ViewController.m
//  XZCalendar
//
//  Created by xianzhiliao on 15/12/18.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "XZCalendarViewCell.h"

@interface ViewController ()
<
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView = ({
        //确定是水平滚动，还是垂直滚动
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        //注册Cell，必须要有
        [collectionView registerClass:[XZCalendarViewCell class] forCellWithReuseIdentifier:[XZCalendarViewCell cellIdentifier]];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.opaque = NO;
        [self.view addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        collectionView;
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 28;
    }
    else if (section == 1){
        return 29;
    }
    else if (section == 2){
        return 30;
    }
    else return 31;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    identifier = [XZCalendarViewCell cellIdentifier];
    XZCalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.item + 1)];
    cell.dateLabel.textAlignment = NSTextAlignmentCenter;
    cell.reminderLabel.textAlignment = NSTextAlignmentCenter;
    if (indexPath.item % 2 == 0) {
        cell.hidden = YES;
        cell.reminderLabel.hidden = YES;
    }
    else
    {
        cell.hidden = NO;
        cell.reminderLabel.hidden = NO;
        cell.reminderLabel.text = @"reminder";
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 6;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 60);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 0, 15);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZCalendarViewCell * cell = (XZCalendarViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor greenColor];
    cell.layer.cornerRadius = 30;
    cell.layer.masksToBounds = YES;
    
    NSLog(@"text=====%@",cell.dateLabel.text);
    NSLog(@"item======%ld",indexPath.item);
    NSLog(@"section===%ld",indexPath.section);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 设置是否高亮
//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    __kindof UICollectionViewCell * cell = [collectionView cellForItemAtIndexPath:indexPath];
//    if (cell) {
//        
//    }
//}

@end
