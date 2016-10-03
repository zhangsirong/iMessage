//
//  MessagesViewController.m
//  MessagesExtension
//
//  Created by admin on 16/9/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MessagesViewController.h"

@interface MessagesViewController ()<MSStickerBrowserViewDataSource>

@property (nonatomic,strong) NSMutableArray *stickers;

@end

@implementation MessagesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadStickers];
    [self createStickerBrowser];
}

//加载表情包
- (void)loadStickers {
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 1; i < 11; i++) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"scoops%02d_sticker",i] withExtension:@"png"];
        MSSticker *sticker = [[MSSticker alloc] initWithContentsOfFileURL:url localizedDescription:@"" error:nil];
        [arrayM addObject:sticker];
    }
    self.stickers = arrayM;
}

-(void)createStickerBrowser{
    MSStickerBrowserViewController *controller = [[MSStickerBrowserViewController alloc] initWithStickerSize:MSStickerSizeSmall];
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    controller.stickerBrowserView.backgroundColor = [UIColor greenColor];
    controller.stickerBrowserView.dataSource = self;
    controller.view.translatesAutoresizingMaskIntoConstraints = NO;

    //自动布局
    [self.view.topAnchor constraintEqualToAnchor:controller.view.topAnchor].active = YES;
    [self.view.bottomAnchor constraintEqualToAnchor:controller.view.bottomAnchor].active = YES;
    [self.view.leftAnchor constraintEqualToAnchor:controller.view.leftAnchor].active = YES;
    [self.view.rightAnchor constraintEqualToAnchor:controller.view.rightAnchor].active = YES;
}

#pragma mark - MSStickerBrowserViewDataSource
-(NSInteger)numberOfStickersInStickerBrowserView:(MSStickerBrowserView *)stickerBrowserView{
    return self.stickers.count;
}

-(MSSticker *)stickerBrowserView:(MSStickerBrowserView *)stickerBrowserView stickerAtIndex:(NSInteger)index{
    return self.stickers[index];
}
@end
