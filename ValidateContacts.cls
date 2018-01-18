public class ValidateContacts {

    public  void applyValidation()
    {
        Validation_Setting__c vcs = Validation_Setting__c.getOrgDefaults();
		System.debug(vcs);
		Validation_Setting__c inst = Validation_Setting__c.getInstance('a0Q7F000000fuSJUAY');
		System.debug(inst);



    }
 }