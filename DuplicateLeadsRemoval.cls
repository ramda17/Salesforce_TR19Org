global class DuplicateLeadsRemoval implements Database.Batchable<SObject>{
	public static final String STR_SEPARATOR = '_';
	global Database.QueryLocator start(Database.BatchableContext bc){
		System.debug('..rd..//inside start method');
		return Database.getQueryLocator(
		'SELECT LastName, Email FROM Lead WHERE Name != NULL AND Email != NULL'
		);
	}

	global void execute(Database.BatchableContext bc, List<Lead> leadList){
		System.debug('..rd..//inside execute method' + leadList);
		Map<String,Lead> emailMap = new Map<String,Lead>();
		List<Lead> duplicateLeadList = new List<Lead>();
		for(Lead ld : leadList){
			String key = ld.Email + STR_SEPARATOR + ld.LastName;
			if(!emailMap.containsKey(key)){
				emailMap.put(key,ld);
			} else{
				duplicateLeadList.add(ld);
			}
		}
		System.debug('..rd..//deleting duplicate Lead'+duplicateLeadList);
		if(duplicateLeadList.size() <= 0){
			return;
		}
		if(duplicateLeadList.size() > 0){
			delete duplicateLeadList;
		}
	}

	global void finish(Database.BatchableContext bc){
		System.debug('..rd..//inside finish method');
	}
}