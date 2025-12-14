## ATM Number Format 
- Active: true
- Formula: NOT(REGEX(ATM_Number__c, "^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}$"))
- Error Message: Enter a valid 16-digit ATM number

## Doctor Name Format Validation Rule
- Active: true
- Formula: NOT(REGEX(Name, "^[A-Z\\.\\s]+$"))
- Error Message: Name must be entered in the correct format (uppercase letters and spaces only)


## Doctor ID Format 
- Active: true
- Formula: NOT(REGEX(Doctor_ID__c, "^DOC-[0-9]{4}$"))
- Error Message: Doctor ID must be in the format DOC-1234

## Doctor License Number format
- Active: true
- Formula: NOT(REGEX(Doctor_License_Number__c, "^DLN-[0-9]{6}$"))
- Error Message: License number must be in the format DLN-123456


## PAN Number Format 
- Active: true
- Formula: NOT(REGEX(PAN_Number__c, "^[A-Z]{5}[0-9]{4}[A-Z]{1}$"))
- Error Message: Enter a valid PAN number


## Phone Number Format 
- Active: true
- Formula: NOT(REGEX(Phone__c, "^[6-9][0-9]{9}$"))
- Error Message: Enter a valid 10-digit phone number


## PIN Code Format Validation Rule
- Active: false
- Formula: NOT(REGEX(Pincode__c, "^[1-9][0-9]{5}$"))
- Error Message: PIN code must be 6 digits and cannot start with 0

