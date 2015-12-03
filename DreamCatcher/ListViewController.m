//
//  ListViewController.m
//  DreamCatcher
//
//  Created by Richard Martin on 2015-12-02.
//  Copyright © 2015 richard martin. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *titlesArray; // array to collect dream titles from user

@property NSMutableArray *descriptionsArray; // array to collect dream descriptions from user


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlesArray = [NSMutableArray new]; // initialize (dream) titlesArray
    
    self.descriptionsArray = [NSMutableArray new]; // initialize (dream) descriptionsArray
    
    self.editing = false;
    
    
    
}

// logic to allow the user to enter a new dream

-(void)presentDreamEntry {
    
    // logic to create UIAlertController object so user can enter new dream entry
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter New Dream"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    // logic to add a text field to the UIAlertController
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Dream Title";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Dream Description";
    }];
    
    
    // logic to add actions
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           
                                                           UITextField *textFieldOne = alertController.textFields[0];
                                                           UITextField *textFieldTwo = alertController.textFields[1];
                                                           
                                                           [self.titlesArray addObject:textFieldOne.text];
                                                           [self.descriptionsArray addObject:textFieldTwo.text];
                                                           
                                                           [self.tableView reloadData];
                                                       }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:true completion:nil];
    
        
}

// allow user to delete from dream catcher list

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.titlesArray removeObjectAtIndex:indexPath.row];
    
    [self.descriptionsArray removeObjectAtIndex:indexPath.row];
    
    [self.tableView reloadData];
    
}


- (IBAction)onAddButtonTapped:(UIBarButtonItem *)sender {
    
    [self presentDreamEntry];
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSString *titleItem = [self.titlesArray objectAtIndex:sourceIndexPath.row];
    [self.titlesArray removeObject:titleItem];
    [self.titlesArray insertObject:titleItem atIndex:destinationIndexPath.row];
    
    NSString *descriptionItem = [self.descriptionsArray objectAtIndex:sourceIndexPath.row];
    [self.descriptionsArray removeObject:descriptionItem];
    [self.descriptionsArray insertObject:descriptionItem atIndex:destinationIndexPath.row];
    
    [self.tableView reloadData];
    
    
}


- (IBAction)onEditButtonTapped:(UIBarButtonItem *)sender {
    
    if (self.editing) {
        
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
        
    } else {
        
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
        
    }
    
    
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.titlesArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [self.titlesArray objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DetailViewController *detailVC = segue.destinationViewController;
    
    detailVC.titleString = [self.titlesArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    
    detailVC.descriptionString = [self.descriptionsArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    
    
    
}


@end
