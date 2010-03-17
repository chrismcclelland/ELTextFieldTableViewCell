//  Copyright (c) 2010 Ecliptic Labs
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//  http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//  
//  RootViewController.m
//  ELTextFieldCellExample
//
//  Created by Chris McClelland on 17/03/2010.
//  Copyright Ecliptic Labs 2010. All rights reserved.
//

#import "RootViewController.h"
#import "ELTextFieldTableViewCell.h"


@implementation RootViewController


- (void)viewDidLoad {
    [super viewDidLoad];

     self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
}


#pragma mark Table view methods


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	static NSString *CellIdentifier = @"ELTextFieldTableViewCell";
	
	ELTextFieldTableViewCell *cell = (ELTextFieldTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier]; 
	
    if (cell == nil) {
		cell = [[[ELTextFieldTableViewCell  alloc] initWithStyle:UITableViewCellStyleSubtitle
												 reuseIdentifier:CellIdentifier] autorelease];
		cell.textField.delegate = self;
		cell.editEnabled = NO; // when using self.editButtonItem to enable editing
		cell.textField.tag = indexPath.row; // we'll use ths to store the row number (works for 1 section tableView)
    }
	
	
	switch(indexPath.row) {
		case 0:
			cell.textField.text = @"TextFieldCell";
			break;
		case 1:
			cell.textLabel.text = @"Email";
			cell.textField.text = @"Fluid Width Label";
			break;
		case 2:
			cell.textLabelWidth = 66;
			cell.textField.text = @"Fixed Width Label";
			cell.textLabel.text = @"Country";
			break;
		case 3:
			cell.textField.text = @"";
			cell.textField.placeholder = @"Placeholder";
			break;
		default:
			break;
	}
	
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    return UITableViewCellEditingStyleNone;
}


#pragma mark Editing


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
	[super setEditing:editing animated:animated];
	
	if(editing){
		
		ELTextFieldTableViewCell *cell = (ELTextFieldTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
		[cell.textField becomeFirstResponder];
		
		UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																					  target:self
																					  action:@selector(cancel:)];
		
		[self.navigationItem setLeftBarButtonItem:cancelButton animated:YES];
		[cancelButton release];
		
		
		
	} else {
		
		self.navigationItem.leftBarButtonItem = nil;
		
		

	}
	
}

#pragma mark Actions

-(void)cancel:(SEL)sender {
	[self setEditing:NO animated:YES];

	[self.navigationItem setLeftBarButtonItem:nil animated:YES];

	[self.tableView reloadData];
}




#pragma mark TextField Delegate Methods


-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
	
	int tag = textField.tag;

	ELTextFieldTableViewCell *cell = (ELTextFieldTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:tag+1 inSection:0]];
	
	if (cell) 
		[cell.textField becomeFirstResponder];
	 else 
		 [textField resignFirstResponder];
	
	return NO; 
}

#pragma mark Memory Management

- (void)dealloc {
    [super dealloc];
}


@end

