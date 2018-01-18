public with sharing class Associate_Account {

//Following method autumatically associates a contact created with respective account based on Email domain
	public static void insertContactOnAccount(){
		List<Account> accountList = new List<Account>();
		List<Contact> contactList = [
									SELECT  AccountId
									,		Email
									, 		Account.Name
									,		Account.Id
									,		MailingStreet
									,		MailingState
									FROM 	Contact
									WHERE	Account.Name != NULL AND Id IN : Trigger.new
									];
		for(Contact cont : contactList)
		{
			Account accObj = new Account(Id = cont.Account.Id);
			accObj.Name = cont.Account.Name;
			accObj.BillingStreet = cont.MailingStreet;
			accObj.BillingState = cont.MailingState;
			accObj.Email__c = cont.Email;
			System.debug(accObj.Email__c + ' ' +cont.Email);
			update accObj;
		}

	}


}