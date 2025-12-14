## Consultation Fee Required When Disease Is Provided
- Formula: AND(
  ISBLANK(Consulation_Fee__c),
  NOT(ISBLANK(Desease__c))
)
- Error Message: Consultation fee is required when disease is specified


## Status Required When Discharge Date Is Provided
- Active: true
- Formula: AND(
  NOT(ISBLANK(Discharge_Date__c)),
  ISBLANK(TEXT(Status__c))
)
- Error Message: Please select the status


## Room Cost Per Day Range Rule
- Active: true
- Formula: AND(
  NOT(ISBLANK(Room_Cost_Per_Day__c)),
  OR(
    Room_Cost_Per_Day__c < 100,
    Room_Cost_Per_Day__c > 25000
  )
)
- Error Message: Room cost per day must be between 100 and 25,000


## Room Cost Per Day Validation Rule
- Active: false
- Formula: AND(
  NOT(ISBLANK(Room_Cost_Per_Day__c)),
  OR(
    Room_Cost_Per_Day__c <= 0,
    Room_Cost_Per_Day__c > 10000
  )
)
- Error Message: Room cost per day must be greater than 0 and less than or equal to 10,000


## Phone and Mobile Rule
- Active: true
- Formula: AND(
  NOT(ISBLANK(Phone__c)),
  ISBLANK(Mobile__c)
)
- Error Message: Both phone and mobile must be entered


## Payment Status Cannot Be Blank When Fee Paid Is Entered
- Active: true
- Formula: AND(
  NOT(ISBLANK(Fee_Paid__c)),
  ISBLANK(TEXT(Payment_Status__c))
)
- Error Message: Please select the payment status


## Room fee must be between 1 and 10,000
- Active: true
- Formula: AND(
  ISBLANK(Room_Cost_Per_Day__c),
  OR(
    Room_Cost_Per_Day__c <= 0,
    Room_Cost_Per_Day__c > 10000
  )
)
- Error Message: Room fee must be between 0 and 10,000


## Email and Address Required for New Records
- Active: true
- Formula: AND(
  ISNEW(),
  OR(
    ISBLANK(Email__c),
    ISBLANK(Address__c)
  )
)
- Error Message: Email and address must be entered for new records


## Mobile Number Validation Rule
- Active: true
- Formula: OR(
  LEN(Mobile__c) <> 10,
  NOT(ISNUMBER(Mobile__c))
)
- Error Message: Enter a valid 10-digit mobile number


## Mandatory Fields Required for New Records
- Active: true
- Formula: AND(
  ISNEW(),
  OR(
    ISBLANK(Desease__c),
    ISBLANK(Join_Date__c),
    ISBLANK(Mobile__c),
    ISBLANK(Consulation_Fee__c)
  )
)
- Error Message: Disease, join date, mobile number, and consultation fee are required for new records


## Fee Paid Range Validation Rule
- Active: true
- Formula: OR(
  Fee_Paid__c <= 0,
  Fee_Paid__c >= 500000,
  ISBLANK(Fee_Paid__c)
)
- Error Message: Fee paid must be between 1 and 499,999


## Fee paid must be greater than 0 and less than 500,000

- Active: false
- Formula: OR(
  NOT(ISBLANK(Fee_Paid__c)),
  AND(Fee_Paid__c <= 0, Fee_Paid__c >= 500000)
)
- Error Message: Fee paid must be between 1 and 499,999


## Discharge Date Required When Status Is Discharged
- Active: true
- Formula: AND(
  IF(ISPICKVAL(Status__c, 'Discharged'), true, false),
  ISBLANK(Discharge_Date__c)
)
- Error Message: Discharge date must be entered when status is Discharged


## Join Date Must Be Earlier Than Discharge Date
- Active: true
- Formula: Join_Date__c > Discharge_Date__c
- Error Message: Join date must be earlier than discharge date


## Date of Birth Must Be Valid
- Active: true
- Formula: Date_of_birth__c > TODAY()
- Error Message: Date of birth must be valid
