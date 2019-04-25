//
//  objLeaveDetails.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 30/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface objLeaveDetails : NSObject

@property(nonatomic,retain)NSString *leaveID;
@property(nonatomic,retain)NSString *ApplicationDate;
@property(nonatomic,retain)NSString *EmployeeCode;
@property(nonatomic,retain)NSString *Employee;
@property(nonatomic,retain)NSString *Department;
@property(nonatomic,retain)NSString *LeaveTypeID;
@property(nonatomic,retain)NSString *LeaveType;
@property(nonatomic,retain)NSString *LeaveFromDate;
@property(nonatomic,retain)NSString *LeaveToDate;
@property(nonatomic,retain)NSString *FullHalf;
@property(nonatomic,retain)NSString *Reason;
@property(nonatomic,retain)NSString *LeaveApplierComment;
@property(nonatomic,retain)NSString *NoOfDays;
@property(nonatomic,retain)NSString *Gender;
@property(nonatomic,retain)NSString *EmployeeID;
@property(nonatomic,retain)NSString *LeaveStatusCode;

@property(nonatomic,retain)NSString *Leaveimages;

@property(nonatomic,retain)NSString *ReportedToStatus;
@property(nonatomic,retain)NSString *ApprovalAuthorityStatus;
@property(nonatomic,retain)NSString *HRStatus;
@property(nonatomic,retain)NSString *FinalAuthorityStatus;


@property(nonatomic,retain)NSString *L1Senior;
@property(nonatomic,retain)NSString *L2Senior;
@property(nonatomic,retain)NSString *L3Senior;
@property(nonatomic,retain)NSString *L4Senior;

@end
