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
 * LoginManager.h
 * Responsible for login/logout and keeping the token information.
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#ifndef SampleDHPApp_LoginManager_h
#define SampleDHPApp_LoginManager_h

#import "Constants.h"

@interface LoginManager : NSObject
{
    NSString *accessToken, *patientUrlIdString;
}

@property (nonatomic, retain) NSString *accessToken, *patientUrlIdString, *organizationUrlIdString;

+ (id)sharedManager;
+ (NSString *) authHeader;

- (NSString *) bearerAuthHeader;
- (void) requestAccessTokenAndLoginForUser: (NSString *)inUser
                                  password: (NSString *)inPassword
                      tokenCompletionBlock: (RequestCompletionBlock) inTokenRequestCompletionBlock
                      loginCompletionBlock: (RequestCompletionBlock) inLoginCompletionBlock;

//- (void) authenticateUserWithTokenForUser: (NSString *)inUser password: (NSString *)inPwd completionBlock: (RequestCompletionBlock)inLoginRequestCompletionBlock;

- (void) logout:(RequestCompletionBlock)inLogoutRequestCompletionBlock;

@end

#endif
