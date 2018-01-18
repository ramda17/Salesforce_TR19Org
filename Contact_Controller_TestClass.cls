@isTest
public with sharing class Contact_Controller_TestClass {
	@isTest
	public static void searchContactTestMethod(){
		ContactController con = new ContactController();
		con.nameStart = 'A';
		Test.startTest();
			con.searchContact();
		Test.stopTest();
		System.assert(con.contacts.size()>0);
	}

	@isTest
	public static void delContactTestMethod(){
		ContactController con = new ContactController();
		con.contactId = '0037F00000JoOyH';
		Test.startTest();
			ContactController.deleteRecords(con.contactId);
		Test.stopTest();
		List<ApexPages.Message> msgs = new List<ApexPages.Message>();
		boolean hasMessage = false;

		for(ApexPages.Message msg : msgs){
			if(msg.getDetail().contains(ContactController.SuccessMsg)){
				hasMessage = true;
			}
		}

		System.assert(hasMessage);
	}
}