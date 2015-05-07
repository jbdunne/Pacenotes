//
//  DataObject.m
//  lean_pacenotes
//
//  Created by Gene Han on 4/27/15.
//  Copyright (c) 2015 ipg. All rights reserved.
//

#import "DataObject.h"

@implementation DataObject

+ (id) sharedObject{
    static DataObject * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (id) init{
    if( self = [super init]){
        _user = [PFUser currentUser];
    }
    return self;
}





@end
