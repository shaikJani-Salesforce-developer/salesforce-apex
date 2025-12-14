# Course Object Validation Rules

## About Course New Fee Rule
- Active: true
- Formula: AND(NOT(ISBLANK(New_Fee__c)), OR(New_Fee__c <= 0, New_Fee__c >= 50000))
- Error Message: Check New Fees
  

## Availability Should Be Online Rule
- Active: true
- Formula: ISPICKVAL(Availablility__c, 'Offline')
- Error Message: Availability Online Only
  

  ## Course Name Changed Rule
- Active: true
- Formula: ISCHANGED(Name)
- Error Message: You Cannot change the Course name

  ## New Fee Must Be Greater Than Old Fee Rule
- Active: true
- Formula: New_Fee__c < Old_Fee__c
- Error Message: New fee must be greater than old fee

## New Fee Minimum Rule
- Active: true
- Formula: New_Fee__c < 10000
- Error Message: New fee must be greater than 10,000

