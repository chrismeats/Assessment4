//
//  Dog.h
//  Assessment4
//
//  Created by ETC ComputerLand on 8/14/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Person;

@interface Dog : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * breed;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) Person *person;

@end
