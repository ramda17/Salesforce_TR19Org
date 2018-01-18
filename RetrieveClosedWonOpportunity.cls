global class RetrieveClosedWonOpportunity implements Database.Batchable<sObject>, Database.Stateful{

	global List<Opportunity> opportunityList = new List<Opportunity>();
	global Integer recordsProcessed = 0;
	global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
		System.debug('..rd..inside the start method');

		return Database.getQueryLocator(
		' SELECT' +
		'('+
			' SELECT Name, Amount, EmailSent__c' +
				 ' FROM 	Opportunities '+
		') '+
		',( ' +
			' SELECT Email '+
			' FROM 	Contacts '+
			' ORDER BY LastModifiedDate '+
			' LIMIT 1'+
		  ')'+
		' FROM Account '+
		' WHERE Id IN ('+
						'SELECT AccountId FROM Opportunity '+
						'WHERE  StageName= \'Closed Won\' '+
		 ' )'+
		 ' AND'+
		 ' Id IN ('+
					' SELECT AccountId FROM Contact'+
					' WHERE Level__c=\'Primary\''+
				' )'
		);
		//SELECT Account.Name FROM Contact
	}

    global void execute(Database.BatchableContext bc, List<Account> oppRecords){
		Decimal total;
		System.debug(oppRecords);
		/*
			List of Emails to be sent
		*/
		List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		List<String> sendTo = new List<String>();
		Map<String,Decimal> opportunityData = new Map<String,Decimal>();
		for(Account acc : oppRecords){
			for(Opportunity opp : acc.Opportunities){
				total = total + opp.Amount;
				// 	nameOfOpp = acc.Name;
				opportunityData.put(opp.Name, opp.Amount);
			}
			sendTo.add(acc.Contacts.get(0).Email);
		}
		mail.setToAddresses(sendTo);
		mail.setSubject('Closed Won Opportunities ');
		mail.setPlainTextBody(opportunityData + ' Total:'+total);
		mails.add(mail);
		System.debug('..rd..entire mail body=== '+mail);
		System.debug('..rd..==='+mails);
		try{
			Messaging.sendEmail(mails);
			System.debug('done..rd');
		}
		catch(Exception e){System.debug('exception while sending mail:'+e.getMessage());}


}

    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
		System.debug('..rd..Records Processed' + recordsProcessed);
		//List<Opportunity> opportunityList = new List<Opportunity>();
	}
}