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
//  ELTextFieldTableViewCell.m
//  ELTextFieldCellExample
//
//  Created by Chris McClelland on 17/03/2010.
//  Copyright 2010 Ecliptic Labs. All rights reserved.
//
//  Simple Example of a text field 

#import "ELTextFieldTableViewCell.h"

#define xSpacing 10

@implementation ELTextFieldTableViewCell

@synthesize textField, textLabelWidth, editEnabled;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle // note that it's forced to use UITableViewCellStyleSubtitle
					reuseIdentifier:reuseIdentifier]) { 
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        textField = [[UITextField alloc] initWithFrame:CGRectZero];
		textField.clearsOnBeginEditing = NO;
		textField.clearButtonMode = UITextFieldViewModeWhileEditing;
		textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		textField.font = [UIFont boldSystemFontOfSize:15.0f];
		self.textLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
		[self.contentView addSubview:textField];    
		
		self.contentView.backgroundColor  = [UIColor clearColor];
		self.textLabel.font = [UIFont systemFontOfSize:15.0f];
		self.textLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1.0];
		
		self.editEnabled = YES;
	}
    return self;
}


- (void)layoutSubviews {
	
	[super layoutSubviews];
	
	
	if (textLabelWidth) {
		CGRect textLabelFrame = self.textLabel.frame;
		textLabelFrame.size.width = textLabelWidth;
		self.textLabel.frame = textLabelFrame;
		self.textLabel.adjustsFontSizeToFitWidth = YES;
	} 
	
	if (self.textLabel.text) {
		textField.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame) + xSpacing, 0, 
									 self.contentView.frame.size.width - CGRectGetMaxX(self.textLabel.frame) - (xSpacing * 2), 
									 self.contentView.frame.size.height);
	} else {
		textField.frame = CGRectMake(xSpacing, 0, self.contentView.frame.size.width - (xSpacing * 2), self.contentView.frame.size.height);
	}
	
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
	if (!editEnabled){
		self.textField.enabled = editing;
	}
	

}

- (void)dealloc {
	[textField release];
    [super dealloc];
}


@end
