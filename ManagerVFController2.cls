public with sharing class ManagerVFController2 {
    public List<Account> acct {get; set;}
    public String searchString {get; set;}
    public static String lessThanThreeWarning ='Enter atleast 3 characters';
    public static String doesNotExistInfo ='This account name does not exist';
    //Controller Constructor
    public ManagerVFController2(){

        //Account records
        acct = [
        SELECT Name
        ,      Id
        ,      Phone
        FROM   Account
        ];
    }

    //Searches element entered in the search box
    public void search(){
        if(searchString.length() > 2){
            acct = [
            SELECT Name
            ,        Id
            ,        Phone
            FROM     Account
            WHERE    Name
            LIKE:    searchString + '%'
            ];
        } else {
                 System.debug('working');
                 ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,ManagerVFController2.lessThanThreeWarning);
                 ApexPages.addMessage(msg);
           }
           if(acct.isEmpty() == true){
               ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.INFO,ManagerVFController2.doesNotExistInfo);
               ApexPages.addMessage(msg);
           }
    }

    //Clears the search logs
    public void clear(){
        acct.clear();
    }

    // public void relatedContacts(){
    //     List<Contact> relContacts = [
    //         SELECT  FirstName
    //              ,  LastName
    //           FROM  Contact
    //          WHERE  Account.Id =:accountId
    //     ];
    // }
}