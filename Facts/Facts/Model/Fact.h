//
//  Fact.h
//  Facts
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface Fact : JSONModel

@property (nonatomic) NSString *factTitle;
@property (nonatomic) NSString *factDescription;
@property (nonatomic) NSString *factImageURL;
@property (nonatomic) UIImage *factImage;
@property (nonatomic) bool downloadRequired;

@end
