//
//  RRCell.m
//  03-在Cell中有不定数量个带图Button
//
//  Created by 丁瑞瑞 on 12/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRCell.h"

@interface RRCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
@implementation RRCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setArrM:(NSArray *)arrM
{
    _arrM = arrM;
    
    [self addCollection:arrM];
}
- (void)addCollection:(NSArray *)arr{
    if (arr.count == 0) {
        self.collectionViewWidth.constant = 0;
        self.collectionViewHeight.constant = 0;
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        layout.itemSize = CGSizeMake(0.00000001, 0.00000001);
        
    }else{
        NSInteger col = 3;
        NSInteger row  =  (arr.count - 1) / 3 + 1;
        CGFloat width = col * 90 + (col - 1) * 10;
        CGFloat height = (CGFloat)row * 90 + (CGFloat)(row - 1) * 10;
        self.collectionViewWidth.constant = width;
        self.collectionViewHeight.constant = height;
        UICollectionViewFlowLayout *layout =  (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        layout.itemSize = CGSizeMake(90, 90);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
    }
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.backgroundColor = [UIColor grayColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"RRC"];
    [self.collectionView reloadData];
}
#pragma mark - dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"---------%zd",self.arrM.count);
    return self.arrM.count;
}
UICollectionViewCell *cell;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RRC" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}
@end
