//
//  GLTestSeeMovieVC.m
//  pack_ijkplayer
//
//  Created by mac on 16/5/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLTestSeeMovieVC.h"
#import "IJKMoviePlayerViewController.h"

@interface GLTestSeeMovieVC ()

/** IJKMoviePlayer */
@property (nonatomic, strong) IJKMoviePlayerViewController *ijkMoviePlayerVC;

@end

@implementation GLTestSeeMovieVC

-(IJKMoviePlayerViewController *)ijkMoviePlayerVC
{
    if (_ijkMoviePlayerVC == nil) {
        _ijkMoviePlayerVC = [[IJKMoviePlayerViewController alloc] init];
    }
    return _ijkMoviePlayerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    
    [btn setTitle:@"点击跳转播放控制器" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(pushTest:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn sizeToFit];
    
    [self.view addSubview:btn];
    
    }

- (void)pushTest:(UIButton *)btn
{
    
    
//    @"http://cn-cq2-cu.acgvideo.com/vg6/d/9a/7821732-1.flv?expires=1464865800&ssig=eVLxQc80ivCNm4fWpSdhzw&oi=456114645&player=1&or=1885007044&rate=0
    
//    网络视频：九筒
//    http://cn-cq2-cu.acgvideo.com/vg6/d/9a/7821732-1.flv?expires=1464946200&ssig=E7_5u3n3F3Bl3mhmIA4fCg&oi=456114645&player=1&or=1885007044&rate=0
    
    IJKMoviePlayerViewController *playerVC = [IJKMoviePlayerViewController InitVideoViewFromViewController:self withTitle:@"GLTest" URL:[NSURL URLWithString:@"http://cn-cq2-cu.acgvideo.com/vg6/d/9a/7821732-1.flv?expires=1464976200&ssig=iL2m0AdqDmp1l6nPahqUmA&oi=2018899911&player=1&or=1885007044&rate=0"] isLiveVideo:YES isOnlineVideo:NO isFullScreen:NO completion:nil];
    [self addChildViewController:playerVC];
    [self.view addSubview:playerVC.view];
    
    
//    [IJKMoviePlayerViewController presentFromViewController:self withTitle:@"GLTest" URL:[NSURL URLWithString:@"http://live-play.acgvideo.com/live/367/live_1998535_9286339.flv"] isLiveVideo:YES isOnlineVideo:YES isFullScreen:YES completion:nil];
//
    
    /** 判断直播是否开启,并执行退出 */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [playerVC GoBack];
    });
    
    
//    http://live-play.acgvideo.com/live/145/live_6999422_4896146.flv
//    B-飞碟说
//    http://cn-gdyj2-cu.acgvideo.com/vg7/0/e9/7624928-1-hd.mp4?expires=1463672700&ssig=KnV-u1sDNedzaR39E8O3FA&oi=2018888132&player=1&or=1895631686&rate=0
//    B-4分钟的papi
//    http://cn-gdyj2-cu.acgvideo.com/vg1/a/61/7583922-1.flv?expires=1463734500&ssig=0Eumr9iDym3gM9SRpU8K9Q&oi=2018888132&player=1&or=1885007044&rate=0
    
//    A-山口山_04猎杀凤凰 - -youku源视频 不能拖,分段
//    http://163.177.2.46/youku/6775F154CDD30821A2FA853455/0300020300573C42C33CBD2F3DDDFADD92F895-1BF2-1AEC-FD75-E4A99F85FE77.flv?nk=58870661668_24394319589&ns=0_21159760&special=true
    
//    Y-炉石会长
//    http://175.43.20.15/hdl3.douyutv.com/live/16789rhUJTqgnnUb_900.flv?wsSecret=10d8eafe933af90c5176e76b47345e12&wsTime=1463662976&wshc_tag=0&wsts_tag=573db980&wsid_tag=7855c9c4&wsiphost=ipdbm
    
    
}





@end
