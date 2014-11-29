//
//  KUTextField.m
//  AdvertiseWall
//
//  Created by Kurodo on 14-11-3.
//  Copyright (c) 2014年 Kurodo. All rights reserved.
//

#import "KUTextField.h"

@implementation KUTextField

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , _horizontalPadding , _verticalPadding );
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , _horizontalPadding , _verticalPadding );
}

@end
