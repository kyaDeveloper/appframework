//
//  AES128.m
//  ocCrazy
//
//  Created by dukai on 16/1/12.
//  Copyright © 2016年 dukai. All rights reserved.
//

#import "AES128.h"

#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

static char base64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
@implementation AES128


+(NSString *)AES128Encrypt:(NSString *)plainText withKey:(NSString *)key withIV:(NSString *)iv
{
    
//    if( ![self validKey:key] ){
//        return nil;
//    }
//    
//    char keyPtr[kCCKeySizeAES128+1];
//    memset(keyPtr, 0, sizeof(keyPtr));
//    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
//    
//    
//    char ivPtr[kCCBlockSizeAES128+1];
//    memset(ivPtr, 0, sizeof(ivPtr));
//    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
//    
//    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
//    NSUInteger dataLength = [data length];
//    
//    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
//    unsigned long newSize = 0;
//    
//    if(diff > 0)
//    {
//        newSize = dataLength + diff;
//        NSLog(@"diff is %d",diff);
//    }
//    
//    char dataPtr[newSize];
//    memcpy(dataPtr, [data bytes], [data length]);
//    for(int i = 0; i < diff; i++)
//    {
//        dataPtr[i + dataLength] =0x0000;
//    }
//    
//    size_t bufferSize = newSize + kCCBlockSizeAES128;
//    void *buffer = malloc(bufferSize);
//    memset(buffer, 0, bufferSize);
//    
//    size_t numBytesCrypted = 0;
//    
//    //0x0000
//    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
//                                          kCCAlgorithmAES128,
//                                          0x0000,
//                                          [key UTF8String],
//                                          kCCKeySizeAES128,
//                                          [iv UTF8String],
//                                          dataPtr,
//                                          sizeof(dataPtr),
//                                          buffer,
//                                          bufferSize,
//                                          &numBytesCrypted);
//    
//    if (cryptStatus == kCCSuccess) {
//        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
//        return [GTMBase64 stringByEncodingData:resultData];
//    }
//    free(buffer);
//    return nil;
    
    
    char keyPtr[kCCKeySizeAES128]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSData *plain = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [plain length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeAES128,
                                          [iv UTF8String],
                                          [plain bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        NSData *tempData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        
        NSMutableString *dest = [[NSMutableString alloc] initWithString:@""];
        
        unsigned char * working = (unsigned char *)[tempData bytes];
        
        int srcLen = (int)[tempData length];
        
        for (int i=0; i<srcLen; i += 3) {
            
            for (int nib=0; nib<4; nib++) {
                
                int byt = (nib == 0)?0:nib-1;
                
                int ix = (nib+1)*2;
                
                if (i+byt >= srcLen) break;
                
                unsigned char curr = ((working[i+byt] << (8-ix)) & 0x3F);
                
                if (i+nib < srcLen) curr |= ((working[i+nib] >> ix) & 0x3F);
                
                [dest appendFormat:@"%c", base64[curr]];
                
            }
            
        }
        
        return dest;
        
        
        
        
    }
    
    free(buffer); //free the buffer;
    return nil;

    
}




+(NSString *)processDecodedString:(NSString *)decoded
{
    if( decoded==nil || decoded.length==0 ){
        return nil;
    }
    const char *tmpStr=[decoded UTF8String];
    int i=0;
    
    while( tmpStr[i]!='\0' )
    {
        i++;
    }
    NSString *final=[[NSString alloc]initWithBytes:tmpStr length:i encoding:NSUTF8StringEncoding];
    return final;
    
}

+(NSString *)AES128Decrypt:(NSString *)encryptText withKey:(NSString *)key withIV:(NSString *)iv
{
    
    if( ![self validKey:key] ){
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [key getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [encryptText dataUsingEncoding:NSUTF8StringEncoding];
    data = [GTMBase64 decodeData:data];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,
                                          [key UTF8String],
                                          kCCBlockSizeAES128,
                                          [iv UTF8String],
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        NSString *decoded=[[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        return [self processDecodedString:decoded];
    }
    
    free(buffer);
    return nil;
    
}

+(BOOL)validKey:(NSString*)key
{
    if( key==nil || key.length !=16 ){
        return NO;
    }
    return YES;
}



-(NSString *)processDecodedString:(NSString *)decoded
{
    if( decoded==nil || decoded.length==0 ){
        return nil;
    }
    const char *tmpStr=[decoded UTF8String];
    int i=0;
    
    while( tmpStr[i]!='\0' )
    {
        i++;
    }
    NSString *final=[[NSString alloc]initWithBytes:tmpStr length:i encoding:NSUTF8StringEncoding];
    return final;
    
}

@end
