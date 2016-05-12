//
//  YQAlbumListViewController.m
//  PhotoSelect
//
//  Created by Mopon on 16/4/29.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQAlbumListViewController.h"



@interface YQAlbumListViewController ()

@property (nonatomic ,copy)YQPhotoResult resultHandel;

@end

@implementation YQAlbumListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YQAlbumListTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"albumListCell"];
    
    [self.tableView setTableFooterView:[UIView new]];
    self.tableView.rowHeight = 70;
    
}


-(void)close{

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showPhotoListViewController:(YQPhotoResult)result{

    YQPhotoPickViewController *pickVC = [[YQPhotoPickViewController alloc]init];
    pickVC.assetCollection = [self.albums firstObject];
    pickVC.maxCount = self.maxCount;
    pickVC.Result = result;
    _resultHandel = [result copy];
    [self.navigationController pushViewController:pickVC animated:NO];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.albums.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YQAlbumListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"albumListCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[YQAlbumListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"albumListCell"];
    }

    [cell loadPhotoListData:self.albums[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    YQPhotoPickViewController *picker = [[YQPhotoPickViewController alloc]init];
    picker.assetCollection = self.albums[indexPath.row];
    picker.maxCount = self.maxCount;
    picker.Result = _resultHandel;
    [self.navigationController pushViewController:picker animated:YES];

}

@end
