## Lead Cannot Be Converted Without Email or Industry
- Active: false
- Formula: AND(
    OR(
        ISBLANK(Email),
        ISBLANK(TEXT(Industry))
    ),
    IsConverted
)
- Error Message: Lead cannot be converted if Email or Industry is blank



## Phone Required When Lead Status Is 'Working - Contacted'
- Active: false
- Formula: AND(
    IF(ISPICKVAL(Status, 'Working - Contacted'), true, false),
    ISBLANK(Phone)
)
- Error Message: Phone must be entered when lead status is 'Working - Contacted'
