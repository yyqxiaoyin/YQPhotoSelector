//
//  ViewController.m
//  PhotoSelect
//
//  Created by Mopon on 16/4/28.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "ViewController.h"
#import "YQPhotoSelectController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong)UIImageView *imageView;

@property (nonatomic ,strong)NSMutableArray *imageSource;

@property (nonatomic ,strong)UICollectionView *collectionView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCollectionView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)setUpCollectionView{

    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat photoSize = ([UIScreen mainScreen].bounds.size.width - 3) / 4;
    flowLayout.minimumInteritemSpacing = 1.0;//item 之间的行的距离
    flowLayout.minimumLineSpacing = 1.0;//item 之间竖的距离
    flowLayout.itemSize = (CGSize){photoSize,photoSize};
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, ([UIScreen mainScreen].bounds.size.width - 3) / 4 +20) collectionViewLayout:flowLayout];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource= self;
    
    self.collectionView.pagingEnabled = YES;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    [self.view addSubview:self.collectionView];

}

#pragma UICollectionView --- Delegate


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = cell.contentView.frame;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [cell.contentView addSubview:imageView];
    
    imageView.image = self.imageSource[indexPath.row];

    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 3) / 4, ([UIScreen mainScreen].bounds.size.width - 3) / 4);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageSource.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}



-(void)btnClick{
    
    _imageSource = [NSMutableArray array];

    YQPhotoSelectController *photoSelect = [[YQPhotoSelectController alloc]init];
    
    photoSelect.maxCount = 8;
    
    __weak typeof(self)weakSelf = self;
    
    [photoSelect showInController:self result:^(NSMutableArray * responseObject) {
        
        NSLog(@"%lu",responseObject.count);
        
        self.imageSource = responseObject;
        
        [weakSelf.collectionView reloadData];
        
    }];
    
}


@end
