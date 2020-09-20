//
//  NSString+Encrypt.h
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/8/29.
//  Copyright © 2020 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Encrypt)

- (NSString *)SHA1;

- (NSString *)SHA256;

- (NSData *)SHA256Data;

///对明文加密
+(NSString *)encryptAESWithPlainText:(NSString *)plaintext;

///对密文解密
+(NSString *)decryptAESWithCipherText:(NSString *)ciphertexts;

    
@end

NS_ASSUME_NONNULL_END
