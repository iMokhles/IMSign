//
//  IMSProfilesManager.m
//  IMSign
//
//  Created by iMokhles on 16/05/16.
//  Copyright © 2016 iMokhles. All rights reserved.
//

#import "IMSProfilesManager.h"

@implementation IMSProfilesManager
+(NSDictionary*) getMobileProvisionbyPath:(NSString *)path
{
    NSDictionary* mobileProvision = nil;
    if (!mobileProvision) {
        NSString *provisioningPath = path;
        if (!provisioningPath) {
            mobileProvision = @{};
            return mobileProvision;
        }
        NSString *binaryString = [NSString stringWithContentsOfFile:provisioningPath encoding:NSISOLatin1StringEncoding error:NULL];
        if (!binaryString) {
            return nil;
        }
        NSScanner *scanner = [NSScanner scannerWithString:binaryString];
        BOOL ok = [scanner scanUpToString:@"<plist" intoString:nil];
        if (!ok) { NSLog(@"unable to find beginning of plist");
        }
        NSString *plistString;
        ok = [scanner scanUpToString:@"</plist>" intoString:&plistString];
        if (!ok) { NSLog(@"unable to find end of plist");
        }
        plistString = [NSString stringWithFormat:@"%@</plist>",plistString];
        NSData *plistdata_latin1 = [plistString dataUsingEncoding:NSISOLatin1StringEncoding];
        NSError *error = nil;
        mobileProvision = [NSPropertyListSerialization propertyListWithData:plistdata_latin1 options:NSPropertyListImmutable format:NULL error:&error];
        if (error) {
            NSLog(@"error parsing extracted plist — %@",error);
            if (mobileProvision) {
                mobileProvision = nil;
            }
            return nil;
        }
    }
    return mobileProvision;
}
@end
