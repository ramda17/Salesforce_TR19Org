public class JSON_Example {
		public static void jsonSerialize(){
		Account accObj1 = new Account(Name='Oscorps University', Phone='9893566001', Email__c='osc@oscorps.in');
		Account accObj2 = new Account(Name='Malaya University', Phone='8893566001', Email__c='osc@malaya.in');
		List<Account> listAcc = new List<Account>();
		listAcc.add(accObj1);
		listAcc.add(accObj2);
		System.debug(JSON.serialize(listAcc));
	}
}