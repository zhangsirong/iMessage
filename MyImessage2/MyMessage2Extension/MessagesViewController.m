//
//  MessagesViewController.m
//  MyMessage2Extension
//
//  Created by zsr on 2016/10/2.
//  Copyright © 2016年 zsr. All rights reserved.
//

#import "MessagesViewController.h"

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupButton];
}

- (void)setupButton {
    UIButton *photoButton = [self createButtonWithTitle:@"图片" action:@selector(sendPhoto)];
    UIButton *musicButton = [self createButtonWithTitle:@"音乐" action:@selector(sendMusic)];
    UIButton *videoButton = [self createButtonWithTitle:@"视频" action:@selector(sendVideo)];
    UIButton *stickerButton = [self createButtonWithTitle:@"贴纸" action:@selector(sendStick)];
    UIButton *alterButton = [self createButtonWithTitle:@"自定义" action:@selector(sendAlter)];

    [photoButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [photoButton.rightAnchor constraintEqualToAnchor:musicButton.leftAnchor].active = YES;
    [photoButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [photoButton.heightAnchor constraintEqualToConstant:50].active = YES;
    
    [musicButton.rightAnchor constraintEqualToAnchor:videoButton.leftAnchor].active = YES;
    [musicButton.widthAnchor constraintEqualToAnchor:photoButton.widthAnchor].active = YES;
    [musicButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [musicButton.heightAnchor constraintEqualToConstant:50].active = YES;
    
    [videoButton.rightAnchor constraintEqualToAnchor:stickerButton.leftAnchor].active = YES;
    [videoButton.widthAnchor constraintEqualToAnchor:photoButton.widthAnchor].active = YES;
    [videoButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [videoButton.heightAnchor constraintEqualToConstant:50].active = YES;
    
    [stickerButton.rightAnchor constraintEqualToAnchor:alterButton.leftAnchor].active = YES;
    [stickerButton.widthAnchor constraintEqualToAnchor:photoButton.widthAnchor].active = YES;
    [stickerButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [stickerButton.heightAnchor constraintEqualToConstant:50].active = YES;
    
    [alterButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [alterButton.widthAnchor constraintEqualToAnchor:photoButton.widthAnchor].active = YES;
    [alterButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [alterButton.heightAnchor constraintEqualToConstant:50].active = YES;
}

-(UIButton *)createButtonWithTitle:(NSString *)title action:(SEL)action{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundColor:[self randomColor]];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

-(void)sendPhoto{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"image" withExtension:@"png"];
    [self sendMessageWithURL:url];
}

-(void)sendMusic{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"blank" withExtension:@"mp3"];
    [self sendMessageWithURL:url];
}

-(void)sendVideo{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"moments" withExtension:@"mp4"];
    [self sendMessageWithURL:url];
}

-(void)sendStick{
    [self requestPresentationStyle:MSMessagesAppPresentationStyleCompact];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sticker" withExtension:@"png"];

    MSSticker *sticker = [[MSSticker alloc] initWithContentsOfFileURL:url localizedDescription:@"localizedDescription" error:nil];
    
    [self.activeConversation insertSticker:sticker completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

-(void)sendAlter{
    [self requestPresentationStyle:MSMessagesAppPresentationStyleCompact];
    MSMessageTemplateLayout *layout = [[MSMessageTemplateLayout alloc] init];
    layout.image = [UIImage imageNamed:@"image"];
    layout.imageTitle = @"老虎";
    MSMessage *message = [[MSMessage alloc] init];
    message.layout =layout;
    [self.activeConversation insertMessage:message completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

-(void)sendMessageWithURL:(NSURL *)url{
    [self requestPresentationStyle:MSMessagesAppPresentationStyleCompact];
    [self.activeConversation insertAttachment:url withAlternateFilename:nil completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

-(UIColor *)randomColor{
    CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
