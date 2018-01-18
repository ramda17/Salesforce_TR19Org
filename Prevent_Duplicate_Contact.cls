public class Prevent_Duplicate_Contact{

     String STR_SEPARATOR = '_';
     public static final String STR_EMIL_ERROR = 'Email already exists';
     public static final String STR_PHONE_ERROR = 'Phone already exists';

     //called from trigger
     public void preventDuplicateContactLogic(List<Contact> contactList, Map<Id, Contact> oldContactMap) {

        //filer the Trigger.new => contactList
        List<Contact> filterdContactList = getFilterdListOfContact(contactList, oldContactMap);

        if( true == filterdContactList.isEmpty() ) {
            return;
        }

        System.debug('...trigger executing ');
        // fetch all the existiting email and phone details excluding the one in filterdContactList
        List<Contact> existingContactList = fetchExistitngContactDetails(filterdContactList);

        //populate the set of existingPhoneSet and existingContactEmailSet
        //Ittrate over existingContactList
            //populate email and phone in respective sets

        //Create a set of existing Emails of Contact Records
        Set<String> existingContactEmailSet = new Set<String>();
        Set<String> existingContactPhoneSet = new Set<String>();

        for( Contact con : existingContactList ) {
            if(null != con.Email) {
                existingContactEmailSet.add(con.Email);
            }
            if(null != con.Phone) {
                existingContactPhoneSet.add(con.Phone);
            }
        }

        // Ittrate over filterdContactList
            // check if email or phone exist in set
                // yes then addError msg
            // else add in existing email or phone set
        for(Contact con : filterdContactList) {
            if( existingContactEmailSet.contains(con.Email) ) {
                con.addError(STR_EMIL_ERROR);
            } else {
                existingContactEmailSet.add(con.Email);
            }

            if( existingContactPhoneSet.contains(con.Phone) ) {
                con.addError(STR_PHONE_ERROR);
            } else {
                existingContactPhoneSet.add(con.Phone);
            }
        }

     }

     public static List<Contact> getFilterdListOfContact(List<Contact> contactList, Map<Id, Contact> oldContactMap) {
         //For before insert oldContact is null
         if ( null == oldContactMap  ) {
             oldContactMap = new Map<Id, Contact>();
         }
         List<Contact> filterdContactList = new List<Contact>();
         for(Contact cont : contactList) {
             Contact oldContact = oldContactMap.get(cont.ID) != null ? oldContactMap.get(cont.ID) : new Contact();

            //email or phone not change
            if( cont.Email == oldContact.Email
             && cont.Phone == oldContact.Phone
             ) {
                continue;
            }

            filterdContactList.add(cont);

         }
         return filterdContactList;
     }

     public static List<Contact> fetchExistitngContactDetails(List<Contact> filterdContactList) {
         List<Contact> existingContactList = [
            SELECT Id
                 , Email
                 , Phone
             FROM Contact
            WHERE Id NOT IN :filterdContactList
         ];
         return existingContactList;
     }


     //newContactList is the list of records to be inserted
     public void preventDuplicateContact(List<Contact> newContactList){

         List<Contact> existingEmailList = [SELECT Email FROM  Contact];
         List<Contact> existingPhoneList = [SELECT Phone FROM  Contact];

         //============================================================================================================

            // for(Contact cont : Trigger.new) {
            //     Contact oldContact = Trigger.oldMap.get(acc.ID);
            //     if((cont.Email != oldContact.Email && cont.Email!=NULL) OR (cont.Email != oldContact.Phone && cont.Phone!=NULL)) {
            //         if(oldContact.Email == con.Email OR oldContact.Phone == con.Phone) {
            //             con.addError('Email or Phone already exists');
            //         }
            //     }
            // }
         // ===========================================================================================================


        //Create a set of existing Emails of Contact Records
        Set<String> existingContactEmailSet = new Set<String>();
        for(Contact con : existingEmailList){
            existingContactEmailSet.add(con.Email);
        }

        Set<String> existingContactPhoneSet = new Set<String>();
        for(Contact con : existingPhoneList){
            existingContactPhoneSet.add(con.Phone);
        }

        for(Contact con : newContactList){
            if (existingContactEmailSet.contains(con.Email)){
                con.addError('Email already exists');
            } else{
                existingContactEmailSet.add(con.Email);
               }

           if (existingContactPhoneSet.contains(con.Phone)){
               con.addError('Phone already exists');
           } else{
               existingContactEmailSet.add(con.Email);
              }
        }
    }

 }