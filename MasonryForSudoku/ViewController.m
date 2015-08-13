//
//  ViewController.m
//  MasonryForSudoku
//
//  Created by hxy on 15/8/13.
//  Copyright (c) 2015年 huangdong. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

@interface ViewController ()

@property (nonatomic,copy) NSMutableArray * dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataArr = [NSMutableArray arrayWithArray:@[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888",@"999"]];
    
    [self configUI];
    
}

- (void)configUI
{
    NSInteger columns = 4;
    NSInteger rows = ceilf(self.dataArr.count/(columns*1.0));
    
    UIView * firstView;
    UIView * leftView;
    UIView * topView;
    
    CGFloat width = CGRectGetWidth(self.view.frame)/columns;
    CGFloat height = 50;
    CGFloat leftSpace = 40;
    CGFloat rightSpace = 40;
    CGFloat topSpace = 50;
    CGFloat bottomSpace = 0;
    CGFloat innerHSpcae = 30;
    CGFloat innerVSpace = 50;
    
    for (NSInteger i = 0; i<rows; i++) {
        for (NSInteger j = 0; j<columns && (i*columns+j)<self.dataArr.count; j++) {
            UILabel * l = [[UILabel alloc] init];
            l.text = self.dataArr[i*columns+j];
            l.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
            [self.view addSubview:l];
            
            [l mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            
            if(leftView){
                [l mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(leftView.mas_right).offset(innerHSpcae);
                }];
            }else{
                [l mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.view).offset(leftSpace);
                }];
            }
            
            if (topView) {
                [l mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(topView.mas_bottom).offset(innerVSpace);
                }];
            }else{
                [l mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.view).offset(topSpace);
                }];
            }
            
            leftView = l;
            
            if (j == columns-1) {
                [l mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(self.view).offset(-rightSpace);
                }];
                topView = l;
                leftView = nil;
            }
            
            if (i == 0 && j == 0) {
                firstView = l;
            }else{
                [l mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(firstView.mas_width);
                }];
            }
            
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
