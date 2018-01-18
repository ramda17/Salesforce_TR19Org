public class AccountRecords
{
	public void getAccountRecord_EnrollmentYear()
	{
		List<Account> list1 = [SELECT Name, BillingStreet, BillingState, BillingCountry FROM Account WHERE Enrollment_Year__c INCLUDES ('2010')];
		List<Account> list2 = [SELECT Name, BillingStreet, BillingState, BillingCountry FROM Account WHERE Enrollment_Year__c INCLUDES ('2013','2014')];
		List<Account> list3 = [SELECT Name, BillingStreet, BillingState, BillingCountry FROM Account WHERE BillingState NOT IN ('Maharasta','Kerala') ORDER BY BillingCity DESC NULLS LAST LIMIT 10000];
		
		for(Account acn : list3)
		{
			System.debug(acn);
		}
	}
}