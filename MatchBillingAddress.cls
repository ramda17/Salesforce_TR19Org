public with sharing class MatchBillingAddress {
	public static void matchBillingAddr()
	{
			Boolean flag = false;
			//List<Account> matchedList = new List<Account>();

			System.debug('new'+Trigger.new);
			System.debug('new map'+Trigger.newMap);
			System.debug('old'+Trigger.old);
			System.debug('old map'+Trigger.oldMap);


			List<Account> listFilter = Trigger.new;
			/*List<Account> listFilter = [
																 SELECT Name
																 ,			BillingStreet
																 ,			BillingCity
																 ,			BillingPostalCode
																 ,			BillingCountry
																 ,			BillingState
																 ,			Match_Billing_Address__c
																 FROM 	Account
																 ];

*/

			for(Account acct : listFilter){
				System.debug('inside for loop');
													if(acct.Match_Billing_Address__c == true){

																		System.debug('working inside the if condition');

																		acct.ShippingStreet = acct.BillingStreet;
																		acct.ShippingCity = acct.BillingCity;
																		acct.ShippingPostalCode = acct.BillingPostalCode;
																		acct.ShippingState = acct.BillingState;
																		acct.ShippingCountry = acct.BillingCountry;

																	}

											}
System.debug('this is the final list outside');

						}
}