//
//  ViewController.m
//  Tom猫
//
//  Created by Li Rui on 16/3/12.
//  Copyright © 2016年 Li Rui. All rights reserved.
//

#import "ViewController.h"
#define  WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height
#define BTNWIDTH 60
@interface ViewController ()
{
    UIImageView   *_tomCat;
    UIButton      *_clickBtn;
    UIButton      *_headBtn;
    float       _xTom;
    float       _yTom;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}
-(void)createUI
{
    //Tom猫
    _tomCat=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _tomCat.backgroundColor=[UIColor orangeColor];
    _tomCat.image=[UIImage imageNamed:@"angry_00.jpg"];
    [self.view addSubview:_tomCat];
    
    NSArray *ImgNameBtn=@[@"cymbal",@"drink",@"eat",@"fart",@"pie",@"scratch"];
    for (int i=0; i<ImgNameBtn.count; i++)
    {
        _xTom = 20.0f;
        _yTom = HEIGHT - BTNWIDTH*(i+1);
        if (i>2) {
            _xTom = WIDTH - _xTom-BTNWIDTH;
            _yTom = HEIGHT - BTNWIDTH*(i-2);
        }
        _clickBtn=[[UIButton alloc]initWithFrame:CGRectMake(_xTom, _yTom, BTNWIDTH, BTNWIDTH)];
        [_clickBtn setImage:[UIImage imageNamed:ImgNameBtn[i]] forState:UIControlStateNormal];
        [_clickBtn setTitle:ImgNameBtn[i] forState:UIControlStateNormal];
        [_clickBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_clickBtn];
    }
//
//    //点击脑袋
    _headBtn=[[UIButton alloc]initWithFrame:CGRectMake(60, 120, 230, 210)];
    [_headBtn addTarget:self action:@selector(knockOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_headBtn];
}

//打脑袋
-(void)knockOut
{
    [self tomBtnWithName:@"konckout" count:81];
}

-(void)btnClick:(UIButton *)btn
{
    NSString *titles=btn.currentTitle;
    NSLog(@"%@",titles);
    if ([titles isEqualToString:@"cymbal"]) {
        [self tomBtnWithName:titles count:13];
    }else if ([titles isEqualToString:@"drink"])
    {
        [self tomBtnWithName:titles count:81];
    }
}

#pragma mark -图片加载事件
-(void)tomBtnWithName:(NSString *)name count:(NSInteger)count
{
    //如果正在播放动画，直接退出
    if ([_tomCat isAnimating]) return;
    
    //动画图片的数组
    NSMutableArray *imgArray=[NSMutableArray array];
    //添加动画播放的图片
    for (int i=0; i<count; i++) {
        
        //图像名称
        NSString *imageName=[NSString stringWithFormat:@"%@_%02d.jpg",name,i];
        
        //加载图片
        NSString *path=[[NSBundle mainBundle]pathForResource:imageName ofType:nil];
        UIImage *image=[UIImage imageWithContentsOfFile:path];
        [imgArray addObject:image];
    }
    
    //设置动画数组
    _tomCat.animationImages = imgArray;
    
    //设置动画的重复次数
    _tomCat.animationRepeatCount=1.0f;
    //动画时长
    _tomCat.animationDuration = _tomCat.animationImages.count*0.075;
    //开始动画
    [_tomCat startAnimating];

    //动画结束之后，清理动画数组
    //performSelector定义在NSObject的分类中，是一个基类
    [_tomCat performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:_tomCat.animationDuration];
}

@end
