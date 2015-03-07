/**
 * Copyright (c) 2014-2015 Koninklijke Philips N.V.
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * LoginViewController.m
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import "LoginViewController.h"
#import "PatientInfoViewController.h"
#import "Constants.h"
#import "UrlRequestHandler.h"
#import "LoginManager.h"

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *loginName, *loginPwd;

@property (nonatomic, weak) IBOutlet UIView *authView;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@property (nonatomic, weak) IBOutlet UITextView *errorTextView;

@end

@implementation LoginViewController

NSString *patientIdUrl;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)loginPressed:(id)sender
{
    [self.authView setHidden:NO];
    [self authenticateUser:nil];
}


- (void)authenticateUser: (id)sender
{
    //NSLog(@"%@ - %@", self.loginName.text, self.loginPwd.text);
    
    if ([self.loginName.text length] == 0 || [self.loginPwd.text length] == 0)
    {
        [self.errorTextView setText:@"Username/password empty, please enter and try again."];
        [self.authView setHidden:YES];
    }
    else
    {
        LoginManager *loginManager = [LoginManager sharedManager];
        [loginManager requestAccessTokenAndLoginForUser: self.loginName.text
                                               password: self.loginPwd.text
                                   tokenCompletionBlock: ^(NSError *inError)
                                                            {
                                                               if (inError != nil)
                                                               {
                                                                   [self.errorTextView setHidden:false];
                                                                   [self.errorTextView setText:@"Could not receive token, client credentials wrong or n/w issue"];
                                                                   [self.authView setHidden:YES];
                                                               }
                                                               else
                                                               {
                                                                   // token succesfully received, keep the
                                                                   // authView visible as the user is being
                                                                   // authenticated
                                                               }
                                                           }
                                   loginCompletionBlock: ^(NSError *inError)
                                                            {
                                                                [self.loginPwd setText:@""];
                                                                [self.authView setHidden:YES];
                                                               if (inError != nil)
                                                               {
                                                                   [self.errorTextView setHidden:false];
                                                                   [self.errorTextView setText:@"Username/password wrong, please try again."];
                                                               }
                                                               else
                                                               {
                                                                   [self performSegueWithIdentifier:@"AUTHENTICATED_SEGUE" sender:self];
                                                               }
                                                           }
         ];
        
    }
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"AUTHENTICATED_SEGUE"])
//    {
//        LoginManager *loginManager = [LoginManager sharedManager];
//        patientIdUrl = loginManager.patientUrlIdString; //@"Patient/46";
//        
//        PatientInfoViewController *patientInfoViewController = segue.destinationViewController;
//        patientInfoViewController.patientIdUrl = patientIdUrl;
//    }
//}

@end
