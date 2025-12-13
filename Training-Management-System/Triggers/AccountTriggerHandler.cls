public class AccountTriggerHandler {

    public static void beforeUpsert(List<Account> newList) {
        for (Account acc : newList) {
            if (acc.Name != null) {
                acc.Description = 'Updated by Account Trigger Handler';
            }
        }
    }

    public static void afterUpsert(List<Account> newList, Map<Id, Account> oldMap) {
        // After insert/update logic
    }
}
