//
//  DogsViewController.m
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "Dog.h"
#import "AddDogViewController.h"
#import "AppDelegate.h"


@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;

@property NSManagedObjectContext *managedObjectContext;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";
    self.managedObjectContext = ((AppDelegate *) [[UIApplication sharedApplication] delegate]).managedObjectContext;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.dogsTableView reloadData];
}

#pragma mark - UITableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.person.dog.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: mmDogCellIdentifier];
    Dog *dog = [self.person.dog allObjects][indexPath.row];
    cell.textLabel.text = dog.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", dog.color, dog.breed];
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Dog *dog = [self.person.dog allObjects][indexPath.row];
    [self.managedObjectContext deleteObject:dog];
    [self.managedObjectContext save:nil];
    [self.dogsTableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AddDogViewController *dvc = segue.destinationViewController;
    if ([segue.identifier isEqualToString: mmAddSegue])
    {
        dvc.person = self.person;
    }
    else
    {
        dvc.dog = [self.person.dog allObjects][self.dogsTableView.indexPathForSelectedRow.row];
    }
}

@end
