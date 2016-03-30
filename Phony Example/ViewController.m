//
//  ViewController.m
//  Phony Example
//
//  Created by Justin Brower on 3/28/16.
//  Copyright © 2016 Pushy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textField;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textField becomeFirstResponder];
}

- (void)authenticate:(id)sender {
    [[Phony sharedPhony] confirmPhoneNumber:textField.text completion:^(NSString *replyTo, NSString *text, NSError *error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           if (error) {
               // show the error
               [self showMessage:[error localizedDescription]];
           } else {
               // perform the next step of authentication
               [[Phony sharedPhony] authenticateWithDefaultTextMessageDialog:replyTo content:text handler:^(BOOL authenticated, NSString *firebase) {
                   if (authenticated) {
                       [self showMessage:[NSString stringWithFormat:@"Authenticated! Firebase token: %@", firebase]];
                   } else {
                       [self showMessage:@"Couldn't authenticate."];
                   }
               }];
           }
       });
    }];
}

/* Show a popup message */
- (void)showMessage:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Pushy" message:message preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:controller animated:YES completion:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
