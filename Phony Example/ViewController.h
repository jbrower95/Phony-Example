//
//  ViewController.h
//  Phony Example
//
//  Created by Justin Brower on 3/28/16.
//  Copyright © 2016 Pushy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Phony.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)authenticate:(id)sender;

@end

