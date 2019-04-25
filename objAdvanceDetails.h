//
//  objAdvanceDetails.h
//  Paylite HRMS
//
//  Created by SANDIPAN on 31/03/16.
//  Copyright © 2016 SANDIPAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface objAdvanceDetails : NSObject

@property(nonatomic,retain)NSString *ID;
@property(nonatomic,retain)NSString *ApplicationDate;
@property(nonatomic,retain)NSString *EmployeeCode;
@property(nonatomic,retain)NSString *Employee;
@property(nonatomic,retain)NSString *Department;
@property(nonatomic,retain)NSString *Gender;
@property(nonatomic,retain)NSString *AdvanceStatusCode;
@property(nonatomic,retain)NSString *AdvanceTypeID;
@property(nonatomic,retain)NSString *AdvanceType;
@property(nonatomic,retain)NSString *AdvanceAmount;
@property(nonatomic,retain)NSString *NoOfInstallmentMonth;
@property(nonatomic,retain)NSString *RepaymentAmount;
@property(nonatomic,retain)NSString *YearNO;
@property(nonatomic,retain)NSString *DESCRIPTION_ALIAS;
@property(nonatomic,retain)NSString *reason;
@property(nonatomic,retain)NSString *MonthName;


@property(nonatomic,retain)NSString *ReportedToStatus;
@property(nonatomic,retain)NSString *ApprovalAuthorityStatus;
@property(nonatomic,retain)NSString *HRStatus;
@property(nonatomic,retain)NSString *FinalAuthorityStatus;

@property(nonatomic,retain)NSString *L1Senior;
@property(nonatomic,retain)NSString *L2Senior;
@property(nonatomic,retain)NSString *L3Senior;
@property(nonatomic,retain)NSString *L4Senior;

@end
