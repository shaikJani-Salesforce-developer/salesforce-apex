## Opportunity Close Date Must Be Within 2025
- Active: false
- Formula: OR(
  CloseDate < DATE(2025,01,01),
  CloseDate > DATE(2025,12,31)
)
- Error Message: Close date must be between 01-Jan-2025 and 31-Dec-2025

  

## Close Date Required When Opportunity Stage Is Closed Won
- Active: false
- Formula: AND(
    IF(ISPICKVAL(StageName, 'Closed Won'), true, false),
    ISBLANK(CloseDate)
)
- Error Message: Close date must be entered when stage is Closed Won



## Opportunity Stage Must Be Closed Won
- Active: false
- Formula: NOT(ISPICKVAL(StageName, 'Closed Won'))
- Error Message: Stage must be set to Closed Won
