//
//  main.m
//  ChineseSort
//
//  Created by Evan on 15-8-3.
//  Copyright (c) 2012年 Pingan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"
#import "BankModel.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool{
        
        //1:需要排序的数组
        NSMutableArray *arrayToSort= [[NSMutableArray alloc] initWithArray:@[@"电脑",
                                                                                @"显示器",
                                                                                @"你好",
                                                                                @"推特",
                                                                                @"乔布斯",
                                                                                @"再见",
                                                                                @"暑假作业",
                                                                                @"键盘",
                                                                                @"鼠标",
                                                                                @"谷歌",
                                                                                @"苹果"]];
        NSLog(@"尚未排序:");
        for(int i=0;i<[arrayToSort count];i++){
            NSLog(@"%@",[arrayToSort objectAtIndex:i]);
        }
        
        //2:获取字符串中文字的拼音首字母并与字符串共同存放
        NSMutableArray *bankModels = [NSMutableArray array];
        
        for(int i=0; i < [arrayToSort count]; i++) {
            
            BankModel *bankModel = [[BankModel alloc] init];
            bankModel.bankName = [NSString stringWithString:[arrayToSort objectAtIndex:i]];
            if(!bankModel.bankName){
                bankModel.bankName = @"";
            }
            
            //获取每个汉字的首字母
            if(bankModel.bankName) {
                
                NSString *pinYinResult = [NSString string];
                for(int j = 0;j < bankModel.bankName.length; j++) {
                    
                    NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                                     pinyinFirstLetter([bankModel.bankName characterAtIndex:j])] uppercaseString];
                    pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                bankModel.pingyin = pinYinResult;
            }else{
                bankModel.pingyin = @"";
            }
            [bankModels addObject:bankModel];
        }
        
        //2:输出排序前首字母字符串
        for(int i=0;i<[bankModels count];i++){
            BankModel *bankModel=[bankModels objectAtIndex:i];
            NSLog(@"排序前拼音首字母字符串:%@", bankModel.pingyin);
        }
        
        //3:按照拼音首字母对排序
        NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pingyin" ascending:YES]];
        [bankModels sortUsingDescriptors:sortDescriptors];
        
        //3输出
        for(int i=0;i<[bankModels count];i++){
            BankModel *bankModel = [bankModels objectAtIndex:i];
            NSLog(@"排序后:%@",bankModel.bankName);
        }
    }
    return 0;
}

