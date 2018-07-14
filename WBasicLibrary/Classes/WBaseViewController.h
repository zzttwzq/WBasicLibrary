//
//  WBaseViewController.h
//  wzqFundation
//
//  Created by 吴志强 on 2017/11/3.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import <StoreKit/StoreKit.h>
#import "Definitions.h"

@interface WBaseViewController : UIViewController<SKStoreProductViewControllerDelegate>
@property (nonatomic,assign) BOOL enableTouchCancelEditing;
@property (nonatomic,assign) BOOL showLeftBtn;

@end
