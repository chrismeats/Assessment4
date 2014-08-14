//
//  AddDogViewController.m
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "AddDogViewController.h"
#import "AppDelegate.h"
#import "Dog.h"

@interface AddDogViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *colorTextField;

@property NSManagedObjectContext *managedObjectContext;


@end

@implementation AddDogViewController

//TODO: UPDATE CODE ACCORIDNGLY

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Add Dog";

    self.managedObjectContext = ((AppDelegate *) [[UIApplication sharedApplication] delegate]).managedObjectContext;

    if(self.dog) {
        self.nameTextField.text = self.dog.name;
        self.breedTextField.text = self.dog.breed;
        self.colorTextField.text = self.dog.color;
    }
    
}

- (IBAction)onPressedUpdateDog:(UIButton *)sender
{
    if (!self.dog) {
        self.dog = [NSEntityDescription insertNewObjectForEntityForName:@"Dog" inManagedObjectContext:self.managedObjectContext];
        [self.dog setPerson:self.person];
        // New dog is added
        [[NSNotificationCenter defaultCenter] postNotificationName:@"newDogAdded" object:nil];
    }
    self.dog.name = self.nameTextField.text;
    self.dog.breed = self.breedTextField.text;
    self.dog.color = self.colorTextField.text;
    [self.managedObjectContext save:nil];

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
