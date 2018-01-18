public with sharing class MyController {

    public MyController(ApexPages.StandardSetController controller) {

    }


List<Account> acctRecord  = new List<Account>();

public pageReference getAccountRecords(){
	 	acctRecord = [SELECT Name, Email__c, Phone FROM Account];
		return NULL;
}
	private Account acct;

	public MyController(ApexPages.StandardController sc){
	 this.acct = (Account)sc.getRecord();
	}

	public String getName()
	{
		return 'Hello ' + acct.Name;
	}

}