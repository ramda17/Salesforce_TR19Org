public with sharing class ManagerVFController {

Contact contactName;
List<Account> accountList = new List<Account>();

	public ManagerVFController(ApexPages.StandardController sc){
		accountList = [
									SELECT (SELECT FirstName, LastName FROM Contacts)
										FROM Account
									];
	}
		List<Contact> contactList = new List<Contact>();


		public Contact getContactName(){
			for(Account acct : accountList){
					for(Contact cont : acct.Contacts){
						contactList.add(cont);
					}
			}
			contactName = contactList[0];
			return contactName;

		}
		//public PageReference showAccountList(){
			//return listAccount;
		}