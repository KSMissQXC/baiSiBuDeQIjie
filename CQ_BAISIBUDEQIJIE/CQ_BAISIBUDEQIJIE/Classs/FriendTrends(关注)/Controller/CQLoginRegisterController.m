//
//  CQLoginRegisterController.m
//  CQ_BAISIBUDEQIJIE
//
//  Created by apple on 16/5/3.
//  Copyright © 2016年 KS小么. All rights reserved.
//

#import "CQLoginRegisterController.h"

@interface CQLoginRegisterController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftDistance;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerViewLeftDistance;


@end

@implementation CQLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view insertSubview:self.bgImage atIndex:0];
}


- (IBAction)changeStatusClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    if (sender.isSelected) {
       self.loginViewLeftDistance.constant = -[UIScreen mainScreen].bounds.size.width;
        self.registerViewLeftDistance.constant = -[UIScreen mainScreen].bounds.size.width;
    }else{
        self.loginViewLeftDistance.constant = 0;
        self.registerViewLeftDistance.constant = 0;
    }

    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    
    
}






- (IBAction)disMissClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}




@end
