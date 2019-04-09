//
//  NSString+PPString.h
//  pengpeng
//
//  Created by wang on 2019/3/6.
//  Copyright © 2019 wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (PPString)

/**
 有效的电话号码
 */
- (BOOL) isValidMobileNumber;

/**
 有效的银行卡号
 */
- (BOOL) isValidBankCardNumber;
/**
 有效的邮箱
 */
- (BOOL) isValidEmail;
/**
 有效的字母数字密码
 */
- (BOOL) isValidAlphaNumberPassword;
@end

NS_ASSUME_NONNULL_END
