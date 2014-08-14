//
//  ViewController.m
//  Assessment4
//
//  Created by The Engineerium  on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "DogsViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBarButtonItem;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property UIAlertView *stuckAlert;

@property NSArray *persons;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"navBarColor"];
    if (colorData) {
        UIColor *barColor = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
        self.navigationController.navigationBar.tintColor = barColor;
    }
    self.title = @"Dog Owners";

    [self fetchPersons];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"newDogAdded" object:nil];
}

-(void) changeColor:(NSNotification *) notification
{
    self.addBarButtonItem.tintColor = [UIColor redColor];
}

-(void)fetchPersons
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Person"];
    self.persons = [self.managedObjectContext executeFetchRequest:request error:nil];
    [self.myTableView reloadData];
}

#pragma mark - UITableViewDataSource Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.persons.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: mmCellIdentifier];
    Person *person = self.persons[indexPath.row];
    cell.textLabel.text = person.name;

    return cell;
}

#pragma mark - UIAlertView Methods

//METHOD FOR PRESENTING ALERT VIEW WITH TEXT FIELD FOR USER TO ENTER NEW PERSON
- (IBAction)onAddButtonTapped:(UIBarButtonItem *)sender
{
    self.addAlert = [[UIAlertView alloc] initWithTitle:@"Add a Person"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Add", nil];
    self.addAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *alertTextField = [self.addAlert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;

    [self.addAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.addAlert)
    {

        if (buttonIndex != alertView.cancelButtonIndex)
        {
            //TODO: ADD YOUR CODE HERE FOR WHEN USER ADDS NEW PERSON
            Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
            person.name = [alertView textFieldAtIndex:0].text;

            [self.managedObjectContext save:nil];
            [self fetchPersons];

        }
    }
    else if (alertView == self.colorAlert)
    {
        UIColor *color = [UIColor new];
            if (buttonIndex == 0)
            {
                color = [UIColor purpleColor];
                self.navigationController.navigationBar.tintColor = color;
            }
            else if (buttonIndex == 1)
            {
                color = [UIColor blueColor];
                self.navigationController.navigationBar.tintColor = color;
            }
            else if (buttonIndex == 2)
            {
                color = [UIColor orangeColor];
                self.navigationController.navigationBar.tintColor = color;
            }
            else if (buttonIndex == 3)
            {
                color = [UIColor greenColor];
                self.navigationController.navigationBar.tintColor = color;
            }
        NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:colorData forKey:@"navBarColor"];
        [defaults synchronize];
    }
    else
    {
        if (buttonIndex != alertView.cancelButtonIndex)
        {
            UIAlertView *newAlertView = [[UIAlertView alloc] initWithTitle:@"Lets try this"
                                                                   message:@"1.Write down the question you want to ask \n2.Brainstorm 3 possible solutions \n3.Bring the question and 3 possible answers to an instructor, or learning assistant \n4.Give the Engineerium a high-five"
                                                                  delegate:self
                                                         cancelButtonTitle:@"We found the answer"
                                                         otherButtonTitles:nil, nil];
            [newAlertView show];
        }
    }


}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    [self.colorAlert show];
}
- (IBAction)onPressedPresentStuckBox:(UIButton *)sender
{
    self.stuckAlert = [[UIAlertView alloc] initWithTitle:@"Follow these steps"
                                                        message:@"1.Identify where you are stuck \n2.Use Apple documentation to get a better understand of what has you stuck \n3.Search Google and StackOverflow for possible solutions"
                                                       delegate:self
                                              cancelButtonTitle:@"Found solution"
                                              otherButtonTitles:@"Still Stuck", nil];
    [self.stuckAlert show];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DogsViewController *dvc = segue.destinationViewController;
    dvc.person = self.persons[self.myTableView.indexPathForSelectedRow.row];
}

@end
