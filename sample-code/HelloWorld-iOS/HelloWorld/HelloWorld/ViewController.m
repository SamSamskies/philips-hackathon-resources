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
 * ViewController.m
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import "ViewController.h"
#import "HelloWorldManager.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIButton *getHelloWorldButton;
@property (nonatomic, strong) IBOutlet UILabel *tokenTextView, *helloWorldTextView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.getHelloWorldButton setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction) getToken:(id) sender
{
    [[HelloWorldManager sharedManager] requestAccessTokenWithCompletionBlock:^(NSError *inError, NSString *inResponse)
                                        {
                                            if ( inError == nil
                                                && [[HelloWorldManager sharedManager] accessToken] != nil
                                                && ![[[HelloWorldManager sharedManager] accessToken] isEqualToString:@""])
                                            {
                                                [self.getHelloWorldButton setHidden:NO];
                                                NSString *token = [NSString stringWithFormat:@"Token Received\n%@", [[HelloWorldManager sharedManager] accessToken]];
                                                [self.tokenTextView setText:token];
                                            }
                                            else
                                            {
                                                [self.getHelloWorldButton setHidden:YES];
                                                [self.tokenTextView setText:@"Check Client credentials or maybe network issue, token could not be retrieved."];
                                            }
                                        }];

}

- (IBAction) gtHelloWorld:(id) sender
{
    [[HelloWorldManager sharedManager] requestHelloWorldCompletionBlock:^(NSError *inError, NSString *inResponse)
                                         {
                                             if (inError == nil)
                                             {
                                                 [self.helloWorldTextView setText:inResponse];
                                             }
                                             else
                                             {
                                                 [self.helloWorldTextView setText:@"Token Expired"];
                                             }
                                         }];
}

@end
