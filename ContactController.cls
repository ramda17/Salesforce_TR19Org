public with sharing class ContactController {

    public static String SuccessMsg;
     public List<Contact> contacts {get; set;}
     public  String nameStart {get; set;}
     public  Id contactId {get; set;}
     //strip of alphabets
     List<String> alphabetStrip = new List<String> {'A','B','C','D','E','F','G','H'
                                                    ,'I','J','K','L','M','N','O','P'
                                                    ,'Q','R','S','T','U','V','W','X'
                                                    ,'Y','Z','ALL'
                                                  };


    //getter method fot alphabetStrip
    public List<String> getAlphabetStrip(){
        System.debug(nameStart);
        return alphabetStrip;
    }

   public ContactController(){
       contacts = [
            SELECT FirstName
                 , LastName
              FROM Contact
             WHERE AccountId != NULL
               AND FirstName != NULL
        ];
    }
    /*
    search the contacts the name of which
    starts with the alphabet as contained in the variabl NameStartsWith
    */

    public void searchContact(){
        System.debug('..rd.. ' + nameStart);
        nameStart = this.nameStart;
        System.debug(nameStart);
        contacts = [
                SELECT FirstName
                ,      LastName
                FROM   Contact
                WHERE  AccountId != NULL
                AND    FirstName != NULL
                AND    FirstName LIKE: nameStart + '%'
                ];

    }

    public List<Contact> getContacts(){
        System.debug('Working with contacts');
        System.debug(contacts);
        return contacts;
    }

    @RemoteAction
    public static void deleteRecords(Id contactId){
        System.debug('..rd..');
        List<Contact> contactList = [
            SELECT Id
              ,    Name
              FROM Contact
            WHERE  Id =: contactId
       ];
       System.debug('Inside DeleteResult method');
       delete contactList;
       ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.CONFIRM,ContactController.SuccessMsg);
       ApexPages.addMessage(msg);
    }
}