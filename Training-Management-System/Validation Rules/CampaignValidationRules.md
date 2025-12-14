## Status Must Be Selected Before Activating Campaign
- Active: true
- Formula: AND(
    IF(IsActive, true, false),
    ISBLANK(TEXT(Status))
)
- Error Message: Status must be selected before activating a campaign


## Actual Cost and Expected Revenue Required Before Completing Campaign
- Active: false
- Formula: AND(
    OR(
        ISBLANK(ActualCost),
        ISBLANK(ExpectedRevenue)
    ),
    ISPICKVAL(Status, 'Completed')
)
- Error Message: Actual cost and expected revenue must be entered before marking the campaign as Completed


## Start and End Date Required Before Activating Campaign
- Active: false
- Formula: AND(
    OR(
        ISBLANK(StartDate),
        ISBLANK(EndDate)
    ),
    IF(IsActive, true, false)
)
- Error Message: Start date and end date must be entered before activating the campaign


## Campaign Must Be 'In Progress' Before Activation
- Active: true
- Formula: AND(
    IF(IsActive, true, false),
    NOT(ISPICKVAL(Status, 'In Progress'))
)
- Error Message: Status must be set to 'In Progress' before activating the campaign


## Prevent Changing Campaign Status from Completed
- Active: false
- Formula: AND(
    ISPICKVAL(PRIORVALUE(Status), "Completed"),
    NOT(ISPICKVAL(Status, "Completed"))
)
- Error Message: Campaign status cannot be changed once it is marked as Completed



## Expected Revenue Must Exceed Budgeted Cost
- Active: false
- Formula: OR(
    ExpectedRevenue < (BudgetedCost * 1.1),
    ISBLANK(BudgetedCost),
    ISBLANK(ExpectedRevenue)
)
- Error Message: Expected revenue must be greater than budgeted cost
