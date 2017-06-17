//
//  LTMoviePlayerController.m
//  MiaoBo
//
//  Created by 零號叔叔 on 2017/4/9.
//  Copyright © 2017年 Lenhulk. All rights reserved.
//

#import "LTMoviePlayerController.h"

@implementation LTMoviePlayerController

+ (id) moviePlayerWithFlv:(NSString *)flv{
 
    //设置播放器
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    
    //帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    
    //丢帧率(framedrop) 是在视频帧处理不过来的时候丢弃一些帧达到音画同步的效果
    [options setPlayerOptionIntValue:2 forKey:@"framedrop"];
    
    //-vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    
    //创建播放器
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:flv withOptions:options];
    moviePlayer.view.contentMode = UIViewContentModeScaleAspectFill;
    moviePlayer.shouldAutoplay = NO;
    moviePlayer.shouldShowHudView = NO;    //显示播放器参数
    
    [moviePlayer prepareToPlay];
    
    // 显示工会其他主播和类似主播 (待完成)
    
    return moviePlayer;
}

@end
