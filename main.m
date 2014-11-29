//
//  main.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-10-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#include <string.h>
#import <mach-o/loader.h>
#import <mach-o/dyld.h>
#import <mach-o/arch.h>
#import "UIDevice+Helper.h"

int indexOf(const char *source,const char *what)
{
    char *p = source;
    int i = 0;
    p = strstr(source, what);
    if (p==NULL) {
        return -1;
    }
    else {
        while (source!=p) {
            source++;
            i++;
        }
    }
    
    return i;
}

void printDYLD()
{
    //Get count of all currently loaded DYLD
    uint32_t count = _dyld_image_count();
    
    for(uint32_t i = 0; i < count; i++)
    {
        //Name of image (includes full path)
        const char *dyld = _dyld_get_image_name(i);
        //Get name of file
        int slength = strlen(dyld);
        int j;
        for(j = slength - 1; j>= 0; --j)
            if(dyld[j] == '/') break;
        
        int p = indexOf(dyld, "afc2add");
        if (p > 0) {
            printf("==== what the fuck ====\n");
        }
        printf("%s\n",  dyld);
    }
    
    printf("\n");
}

int main(int argc, char * argv[]) {
    //printDYLD();
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
//    if (![UIDevice isJailbroken]) {
//        NSLog(@"======= not jailbroken ======");
//    }
}