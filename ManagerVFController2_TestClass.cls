/*
	Test class for ManagerVFController2
*/

@isTest
public with sharing class ManagerVFController2_TestClass {
	@isTest
	public static void searchAccountForSingleCharacter(){
		String accountNameStartsWith = 'a';

		Test.startTest();

			//setting the current visualforce page for testing
			Test.setCurrentPage(Page.Manager_VF2);

			//create an object of the controller class
			ManagerVFController2 mvf2 = new ManagerVFController2();

			/*
			 set the searchString present in apex class with the variable's value present in Test Utility class
			 and call the search method
		   */
			mvf2.SearchString = accountNameStartsWith;
			mvf2.search();

		Test.stopTest();

		List<ApexPages.Message> msgs = ApexPages.getMessages();
		boolean hasMessage = false;
		for(ApexPages.Message msg : msgs){
			if(msg.getDetail().contains(ManagerVFController2.lessThanThreeWarning)){
				hasMessage = true;
			}
		}

		System.assert(hasMessage);
	}

	@isTest
	public static void searchAccountTestMethod_for_CharMoreThanThree(){
		String accountNameStartsWith = 'ram';

		Test.startTest();

			//setting the current visualforce page for testing
			Test.setCurrentPage(Page.Manager_VF2);

			//create an object of the controller class
			ManagerVFController2 mvf2 = new ManagerVFController2();

			/*
			 set the searchString present in apex class with the variable's value present in Test Utility class
			 and call the search method
		   */

			mvf2.searchString = accountNameStartsWith;
			mvf2.search();

			Test.stopTest();

			List<ApexPages.Message> msgs = ApexPages.getMessages();
			System.debug(msgs);
			boolean hasMessage = true;
			for(ApexPages.Message msg : msgs){
				if(msg.getDetail().contains(ManagerVFController2.doesNotExistInfo) && msg.getDetail().contains(ManagerVFController2.lessThanThreeWarning)){
					hasMessage = false;
				}
			}

			System.assert(hasMessage);
			System.debug('..rd..'+mvf2.acct.size());
			//System.assert(mvf2.acct.size() > 0);
	}

	@isTest
	public static void accountDoesNotExistTestMethod(){
		String accountNameStartsWith = 'AccountNotPresent';

		Test.startTest();

			//setting the current visualforce page for testing
			Test.setCurrentPage(Page.Manager_VF2);

			//create an object of the controller class
			ManagerVFController2 mvf2 = new ManagerVFController2();
			/*
			 set the searchString present in apex class with the variable's value present in Test Utility class
			 and call the search method
		   */
			mvf2.searchString = accountNameStartsWith;
			mvf2.search();

			List<ApexPages.Message> msgs = ApexPages.getMessages();
			System.debug(msgs);
			boolean hasMessage = false;
			for(ApexPages.Message msg : msgs){
				if(msg.getDetail().contains(ManagerVFController2.doesNotExistInfo)){
					hasMessage = true;
				}
			}
		Test.stopTest();
		System.assert(hasMessage);

	}

	@isTest
	public static void clearAccountSearchLog(){
		ManagerVFController2 mvf2 = new ManagerVFController2();
		mvf2.searchString = 'A';
		Test.startTest();
			mvf2.search();
			System.debug('..rd..before: '+ mvf2.acct.size());
			mvf2.clear();
			System.debug('..rd..after: '+ mvf2.acct.size());
		Test.stopTest();
		System.assert(mvf2.acct.size() == 0);
	}

}