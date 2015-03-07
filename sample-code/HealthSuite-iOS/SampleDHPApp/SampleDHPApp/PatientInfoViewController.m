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
 * PatientInfoViewController.h
 *
 * Created by Himanshu Shrivastava (hshrivastava@gmail.com)
 */

#import "PatientInfoViewController.h"
#import "PatientFeed.h"
#import "HSDPPatient.h"
#import "LoginManager.h"
#import "ObservationFeed.h"
#import "FHIRHumanName.h"
#import "HSDPObservation.h"
#import "OrganizationFeed.h"
#import "HSDPOrganization.h"

@interface PatientInfoViewController ()

@property (nonatomic, strong) IBOutlet UITextView *status, *names, *phones, *addresses, *gender, *birthdate, *organizationName;
@property (nonatomic, strong) IBOutlet UIButton *refreshPatientInfoButton, *refreshObservationButton, *logoutButton, *nextObservationPageButton, *previousObservationPageButton, *observationFilterButton;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *patientRefreshActivityIndicator, *observationRefreshActivityIndicator;
//@property (nonatomic, weak) IBOutlet UITextView *observationTextView;
@property (nonatomic, strong) IBOutlet UITableView *obsTableView;
@property (nonatomic, strong) IBOutlet UILabel *observationPageInfo;

@property (nonatomic, strong) UIActionSheet *observationFilterOptionsPopup;
@property (nonatomic, strong) PatientFeed *patientFeed;
@property (nonatomic, strong) ObservationFeed *observationFeed;
@property (nonatomic, strong) OrganizationFeed *organizationFeed;
@property (nonatomic, strong) RequestCompletionBlock requestObservationCompletionBlock;

@property (nonatomic, strong) NSString *observationFilter;
@property (nonatomic, strong) NSArray *observationFilterOptions;

@end

@implementation PatientInfoViewController

@synthesize patientFeed, observationFeed, organizationFeed, requestObservationCompletionBlock, observationFilter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LoginManager *loginManager = [LoginManager sharedManager];
    self.patientIdUrl = loginManager.patientUrlIdString;
    
    //NSLog(@"patient: %@", self.patientIdUrl );
    
    NSString *observationNameDataFileName = [[NSBundle mainBundle] pathForResource:@"ObservationNamesAndCodes" ofType:@"json"];
    NSData *observationNameData = [NSData dataWithContentsOfFile:observationNameDataFileName];
    NSError *error = nil;
    self.observationFilterOptions = [NSJSONSerialization JSONObjectWithData:observationNameData options:kNilOptions error: &error];
    
    self.observationFilterOptionsPopup = [[UIActionSheet alloc] initWithTitle:@"Observation Filter By:" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    for (NSDictionary *observationInfo in self.observationFilterOptions)
        [self.observationFilterOptionsPopup addButtonWithTitle:[observationInfo objectForKey:@"name"]];
    
    self.observationFilterOptionsPopup.cancelButtonIndex = [self.observationFilterOptionsPopup addButtonWithTitle:@"Cancel"];
    
//    self.observationFilterOptionsPopup.tag = 1;
    
    self.patientFeed = [[PatientFeed alloc] init];
    self.observationFeed = [[ObservationFeed alloc] init];
    self.organizationFeed = [[OrganizationFeed alloc] init];
    
    self.requestObservationCompletionBlock = ^(NSError *inError)
    {
        if (!inError)
        {
            //NSLog(@"DONE");
            //NSLog(@"Count: %lu", [observationFeed.observations count]);
            [self refreshObservationInfoView];
        }
    };
    
    [self refreshPatientInfo:nil];
    [self refreshOrganizationInfo: nil];
    [self refreshObservationInfo:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark OrganizationMethods

- (IBAction) refreshOrganizationInfo: (id)sender
{
    [organizationFeed requestOrganizationInfoWithId:[[LoginManager sharedManager] organizationUrlIdString] completionBlock:^(NSError* inError){
        if (!inError)
        {
            //NSLog(@"DONE");
            [self refreshOrganizationInfoView];
        }
    }];
}

- (void) refreshOrganizationInfoView
{
    if (organizationFeed.organizations == nil)
        return;
    
    HSDPOrganization *organization = [organizationFeed.organizations objectAtIndex:0];
    if (organization != nil)
    {
        [self.organizationName setText:organization.getOrganizationName];
    }
}

#pragma mark PatientMethods

- (IBAction) refreshPatientInfo: (id)sender
{
    [self.patientRefreshActivityIndicator setHidden:NO];
    [patientFeed requestPatientInfoWithId:self.patientIdUrl completionBlock:^(NSError* inError){
        if (!inError)
        {
            //NSLog(@"DONE");
            //NSLog(@"Count: %lu", [patientFeed.patients count]);
            [self refreshPatientInfoView];
            [self.patientRefreshActivityIndicator setHidden:YES];
        }
    }];
}

- (void) refreshPatientInfoView
{
    HSDPPatient *patient = [patientFeed.patients objectAtIndex:0];
    
    [self.status setText:patient.getStatus];
    [self.gender setText:patient.getGender];
    [self.birthdate setText:patient.getBirthdate];
    [self.names setText:[patient.getNames componentsJoinedByString:@"\n"]];
    [self.addresses setText:[patient.getAddresses componentsJoinedByString:@"\n"]];
    [self.phones setText:[patient.getPhones componentsJoinedByString:@"\n"]];
}

#pragma mark ObservationMethods

- (IBAction) refreshObservationInfo:(id)sender
{
    [self.observationRefreshActivityIndicator setHidden:NO];
    [observationFeed requestObservationsForPatientId: [self.patientIdUrl stringByReplacingOccurrencesOfString:@"/Patient/"
                                                                                                   withString:@""]
                                     withObservation: self.observationFilter
                                           withDate1: nil
                                           withDate2: nil
                                     completionBlock: requestObservationCompletionBlock
     ];
}

- (void) refreshObservationInfoView
{
    [self.nextObservationPageButton setHidden:([observationFeed getNextLink] == nil ? YES : NO)];
    [self.previousObservationPageButton setHidden:([observationFeed getPreviousLink] == nil ? YES : NO)];
    
    [self.obsTableView reloadData];
    [self.observationRefreshActivityIndicator setHidden:YES];
    
    NSString *obsPageInfoStr = [NSString stringWithFormat:@"Page %d/%d (%d Records)", observationFeed.getCurrentPageNo, observationFeed.getTotalNoPages, observationFeed.getTotalNumberOfRecords];
    [self.observationPageInfo setText:obsPageInfoStr];
}

- (IBAction) nextObservationButtonPressed:(id)sender
{
    if ([observationFeed getNextLink] != nil)
    {
        [self.observationRefreshActivityIndicator setHidden:NO];
        [observationFeed requestWithUrl:[observationFeed getNextLink] completionBlock:requestObservationCompletionBlock];
    }
}


- (IBAction) previousObservationButtonPressed:(id)sender
{
    if ([observationFeed getPreviousLink] != nil)
    {
        [self.observationRefreshActivityIndicator setHidden:NO];
        [observationFeed requestWithUrl:[observationFeed getPreviousLink] completionBlock:requestObservationCompletionBlock];
    }
}

- (IBAction) selectObservationFilter: (id)sender
{
    [self.observationFilterOptionsPopup showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark ObservationTableViewDelegateMethods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [observationFeed.observations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *obsTableRowIdentifier = @"ObservationRowId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:obsTableRowIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:obsTableRowIdentifier];
    }
    
    
    HSDPObservation *obs = [observationFeed.observations objectAtIndex:indexPath.row];
    
    UITextView *tv = (UITextView *)[cell viewWithTag:1];
    tv.textContainer.maximumNumberOfLines = 1;
    tv.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    
    ((UITextView *)[cell viewWithTag:1]).text = obs.getObservationName;
    ((UITextView *)[cell viewWithTag:2]).text = obs.getObservationValue;
    ((UITextView *)[cell viewWithTag:3]).text = obs.getStatus;
    ((UITextView *)[cell viewWithTag:4]).text = obs.getReliability;
    ((UITextView *)[cell viewWithTag:5]).text = obs.getAppliedDateTimeHumanReadableString;
    
    return cell;
}

#pragma mark ObservationFilterDelegateMethods

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    bool doNothing = false;
    if (buttonIndex == 0)
    {
        self.observationFilter = nil;
        [self.observationFilterButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    else
    {
        if (buttonIndex == self.observationFilterOptions.count)
        {
            // do nothing
            doNothing = true;
        }
        else
        {
            self.observationFilter = [[self.observationFilterOptions objectAtIndex:buttonIndex] valueForKey:@"code"];
            [self.observationFilterButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
    }
    //NSLog (@"Observation Filter: %@", observationFilter);
    if (!doNothing)
        [self refreshObservationInfo:nil];
}


#pragma mark logout

- (IBAction)logout:(id)sender
{
    LoginManager *loginManager = [LoginManager sharedManager];
    [loginManager logout:^(NSError *inError){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
