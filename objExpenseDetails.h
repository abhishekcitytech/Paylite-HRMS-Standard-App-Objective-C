//
//  objExpenseDetails.h
//  Paylite HR
//
//  Created by Sandipan on 10/04/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface objExpenseDetails : NSObject

@property(nonatomic,retain)NSString *expenseID;
@property(nonatomic,retain)NSString *ApplicationDate;
@property(nonatomic,retain)NSString *EmployeeCode;
@property(nonatomic,retain)NSString *Employee;
@property(nonatomic,retain)NSString *EmployeeID;
@property(nonatomic,retain)NSString *Department;
@property(nonatomic,retain)NSString *Gender;
@property(nonatomic,retain)NSString *DecimalPlace;


@property(nonatomic,retain)NSString *voucherDate;
@property(nonatomic,retain)NSString *expenseHeadID;
@property(nonatomic,retain)NSString *expenseHeadType;
@property(nonatomic,retain)NSString *expenseDate;
@property(nonatomic,retain)NSString *expenseAmount;
@property(nonatomic,retain)NSString *expensePayCash;
@property(nonatomic,retain)NSString *expenseDocument;
@property(nonatomic,retain)NSString *expenseRemarks;

@property(nonatomic,retain)NSString *expenseimages;

@property(nonatomic,retain)NSString *ReportedToStatus;
@property(nonatomic,retain)NSString *ApprovalAuthorityStatus;
@property(nonatomic,retain)NSString *HRStatus;
@property(nonatomic,retain)NSString *FinalAuthorityStatus;

@property(nonatomic,retain)NSString *L1Senior;
@property(nonatomic,retain)NSString *L2Senior;
@property(nonatomic,retain)NSString *L3Senior;
@property(nonatomic,retain)NSString *L4Senior;

@end
