//
//  Define.h
//  RentAndPass_Demo
//
//  Created by sergio on 23/12/18.
//  Copyright © 2018 Maubic. All rights reserved.
//

#ifndef Define_h
#define Define_h


#define OmniLockURL @"https://api.rentandpass.com/api"
#define OmniAppkey  @"API_KEY"
#define OmniAppSecret @"API_SECRET"
#define OmniRedirectUri @"http://www.omnitec.com"

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define STATUSBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define NAVIGATIONBAR_HEIGHT 44.0
#define BAR_TOTAL_HEIGHT  (NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT)

#define LS(localized) NSLocalizedString(localized, nil)
#define NET_REQUEST_ERROR_NO_DATA -1001
#define DEFAULT_CONNECT_TIMEOUT  20

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define StrongSelf(strongSelf)  __strong typeof(weakSelf) strongSelf = weakSelf
#define TTWindow [UIApplication sharedApplication].keyWindow
#define TTAppdelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)


// rgb（Hex->decimal）
#define RGBFromHexadecimal(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RGB_A(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define COMMON_BLUE_COLOR RGB(0,185,255)
#define COMMON_FONT_BLACK_COLOR RGB(29,29,38)
#define COMMON_FONT_GRAY_COLOR RGB(178,178,178)


#endif /* Define_h */
