public class AccountCloneHandler {

    static Boolean isNewTransaction = true;
    public static void getRecordsClone(List<Account> listAccRecords) {

        if( false == isNewTransaction
         || true == listAccRecords.isEmpty() ) {
            return;
        }

        List<Account> clonedList = new List<Account>();

        for(Account acc : listAccRecords) {
            Account cloneAccount = acc.clone();
            clonedList.add(cloneAccount);
            isNewTransaction = false;
        }

        if(false == clonedList.isEmpty()) {
            insert clonedList;
        }
    }
}