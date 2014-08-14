//
//  DogsViewController.h
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface DogsViewController : UIViewController

#define mmAddSegue @"AddDogSegue"
#define mmDogCellIdentifier @"dogCell"

@property Person *person;

@end
