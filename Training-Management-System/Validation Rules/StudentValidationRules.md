# Student Object Validation Rules

## Age Rule
- Active: true
- Formula: Age_in_Years__c <= 20
- Error Message: Age Must be Above 20



## Account Number Rule
- Active: true
- Formula: OR(ISBLANK(Account_Number__c), NOT(ISNUMBER(Account_Number__c)))
- Error Message: Enter valid account number


## Date of Birth Rule
- Active: false
- Formula: Date_of_birth__c < TODAY()
- Error Message: Enter Valid Date of Birth

## Gender Rule
- Active: true
- Formula: ISBLANK(TEXT(Gender__c))
- Error Message: Select the Gender
  

## Phone and Mobile Rule
- Active: true
- Formula: OR(ISBLANK(Phone__c), ISBLANK(Mobile__c))
- Error Message: Mobile And Phone Must be enter

- 

## Age Must Be Greater Than 18 Rule
- Active: true
- Formula: Age__c <= 18
- Error Message: Age Must Be Greater Than 18
