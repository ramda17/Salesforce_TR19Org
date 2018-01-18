@isTest(SeeAllData = true)
public with sharing class CaseTestingClass {
	@isTest static void testCaseHandler(){
			List<EFT_Transaction_Status__c> listEFT = new List<EFT_Transaction_Status__c>();
			for(Integer i=0; i<200; i++){
				EFT_Transaction_Status__c eft = new EFT_Transaction_Status__c(
																																			Method_Name__c='Credit Card Address Verification'
																																			, Transaction_Status__c = 'Declined'
																																			
																																			);
					listEFT.add(eft);
		}
				test.startTest();
				insert listEFT;

				test.stopTest();
		System.assert(listEFT.size()>0);
}
}