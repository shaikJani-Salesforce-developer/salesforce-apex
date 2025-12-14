## PAN Number Format Rule
- Active: true
- Formula: NOT(REGEX(PAN_Number__c, "[A-Z]{5}[0-9]{4}[A-Z]{1}"))
- Error Message: Enter a valid PAN number


## Phone and Mobile Rule (Either Missing)
- Active: true
- Formula: AND(ISNEW(), OR(ISBLANK(Phone__c), ISBLANK(Mobile__c)))
- Error Message: Both Phone and Mobile must be entered for new records

  

## Date of Birth Must Be Valid Rule
- Active: true
- Formula: Date_of_birth__c > TODAY()
- Error Message: Enter a valid date of birth
  

## Phone and Mobile Rule (Both Missing)
- Active: true
- Formula: AND(ISNEW(), ISBLANK(Phone__c), ISBLANK(Mobile__c))
- Error Message: Enter both Phone and Mobile for new records

