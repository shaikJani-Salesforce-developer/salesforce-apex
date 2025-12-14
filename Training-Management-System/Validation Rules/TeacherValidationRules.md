## Phone Is Not Blank And Mobile Is Blank Rule
- Active: true
- Formula: OR(NOT(ISBLANK(Phone__c)), ISBLANK(Mobile__c))
- Error Message: Both Phone and Mobile must be entered
  

## Mobile Number Must Be 10 Digits Rule
- Active: true
- Formula: LEN(Mobile__c) <> 10
- Error Message: Mobile number must be 10 digits
