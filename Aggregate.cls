public class Aggregate
{
	/*
	The Method Takes No Parameters
	Returns void
	*/

	//Q.1 Following method finds out closed opportunity details and sum of amount for each current fiscal year
	public void closedOpportunityDetails()
	{

	Map<Integer,Double> opportunityRecord = new Map<Integer,Double>();
		List<AggregateResult> listOpportunity = [
												select  Calendar_Year(CloseDate) fiscalYear
													 ,  SUM(Amount) sumAmount FROM Opportunity
												WHERE IsClosed = true
												Group By Calendar_Year(CloseDate)
												];

		for(AggregateResult opportunityObj : listOpportunity)

			//Creating the map

			opportunityRecord.put((Integer)opportunityObj.get('fiscalYear') , (Double)opportunityObj.get('sumAmount'));

	 	//create key set for the keys to be used in map

	//		Set<Integer> keySetOpportunity = opportunityRecord.keySet();

			for(Integer opportunityKey : opportunityRecord.keySet() )
			//Retrieving the map
				System.debug(opportunityKey + ' ' + opportunityRecord.get(opportunityKey));
	}


	//Q.2 Find total number of Lead records on the basis of Lead Source having Leads greater than 10
	public void leadRecords()
	{

		List<AggregateResult> leadList = [Select  COUNT(l.Id) From Lead l GROUP BY LeadSource HAVING COUNT(l.Id)> 5 ];
		for(AggregateResult leadRecords : leadList)
				System.debug(leadRecords);

		// Q.3 Creating a map for the lead records

			//create a Lead Map
			Map<String, Map<String,Integer>> leadMap = new Map<String, Map<String,Integer>>();

			List<SObject> listLeadMap =  [
				SELECT Status
	 				 , LeadSource
								,		 COUNT(Id) Total
								FROM Lead
								WHERE LeadSource !=NULL
								GROUP BY LeadSource, Status
			  ];

				for(SObject leadObj: listLeadMap ){
				  	if(leadMap.containsKey((String)leadObj.get('LeadSource'))){

				  		leadMap.get(
								(String)leadObj.get('LeadSource')
							).put(
										(String)leadObj.get('Status'), (Integer)leadObj.get('Total')
							);

				  	}else{
				  		Map<String,Integer> valueMap = new Map<String,Integer>();
				  		valueMap.put((String)leadObj.get('Status'), (Integer)leadObj.get('Total'));
				  		leadMap.put((String)leadObj.get('LeadSource'), valueMap);

				  	}

				  }
		  System.debug('lead source ++'+leadMap);
	}

		//--------------------------------------------------------------------------------------------------------------------------------
	/*	Map<String,Map<String,Integer>> leadMainRecordMap = new Map<String,Map<String,Integer>>();
		List<AggregateResult> leadRecordList = [Select  l.Status, l.LeadSource, COUNT(l.Id) Total
												From Lead l
												GROUP BY l.Status, l.LeadSource];


		// Following map is only the value (status, count of records) of original map whose key is the lead source.
		Map<String, Integer> valueLeadRecord = new Map<String, Integer>();

		for(AggregateResult tempLeadMap : leadRecordList)
			valueLeadRecord.put((String)tempLeadMap.get('l.Status'), (Integer)tempLeadMap.get('Total'));

		// Storing the lead records based on Lead Source in first map.
		for(AggregateResult leadRecordObj : leadRecordList)
			leadMainRecordMap.put((String)leadRecordObj.get('l.Status'), valueLeadRecord);
*/


	public void account_contactsRec(){
		// Create a map with Account Id as key and List of Contact records as the value

			//First create a list that stores the account id and name of the contact associated


				List<Contact> contactList = [
								SELECT Account.Id
								,	   FirstName
								FROM   Contact
								LIMIT  100
							  ];

				Map<Id,List<Contact>> contactMap = new Map<Id,List<Contact>>();

				for(Contact cont : contactList) {
					if(!contactMap.containsKey(cont.Account.Id)) {
							// List<Contact> contList = new List<Contact>();
							// contactMap.put(cont.Account.Id, contList);
							// contactMap.get(cont.Account.Id).add(cont);
							List<Contact> contList = new List<Contact>{cont};
							contactMap.put(cont.Account.Id, contList);

					} else{
							contactMap.get(cont.Account.Id).add(cont);
						}


				}
				 for(Id conId : contactMap.keySet())
						{
							System.debug(conId + ' ' + contactMap.get(conId));
						}



/*			for(Contact con : [
								SELECT Account.Id
								,	   FirstName
								FROM   Contact
								LIMIT  100
							  ]
			) {
				List<Contact> contList = contactMap.get(con.Account.Id);
				if(contList == null){
					contList = new List<Contact>();
					contactMap.put(con.Account.Id, contList);
				}
				contList.add(con);
			}
				for(Id accId : contactMap.keySet()){
					System.debug(contactMap.get(accId));
				}
	*/
		}
}