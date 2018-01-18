public with sharing class Case_Handler {
	public static void createCase(List<EFT_Transaction_Status__c> listEFT) {

	 //this trigger fires after insert event
	 //create a list of cases while iterating through Trigger.new

		List<Case> listOfCase = new List<Case>();
	//	List<EFT_Transaction_Status__c> listEFT = Trigger.New;

		List<EFT_Transaction_Status__c> eftList = [
		SELECT Transaction_Status__c
		, Method_Name__c
		, Sales_Header__r.Bill_To_Customer__r.Name
		FROM EFT_Transaction_Status__c
		WHERE ID IN : Trigger.NewMap.keySet()
		];

		for(EFT_Transaction_Status__c eft : eftList) {
			System.debug('inside the for loop' + Trigger.New);
			if(eft.Method_Name__c == 'Credit Card Address Verification'
			   && eft.Transaction_Status__c == 'Declined'
			   && eft.Sales_Header__r.Status__c == 'Open'
			 ) {
						System.debug('inside if');
			 			Case caseObj = new Case();
						caseObj.Status = 'New';
						caseObj.Origin = 'Web';
						caseObj.AccountId =  eft.Sales_Header__r.Bill_To_Customer__c;
						caseObj.Priority = 'High';
						caseObj.Type = 'Other';
						caseObj.Subject =   eft.Sales_Header__r.Bill_To_Customer__r.Name + 'This is case for maintenance '+ caseObj.Type;
						System.debug('working');
						listOfCase.add(caseObj);
				}
		}
		insert listOfCase;
	}
}