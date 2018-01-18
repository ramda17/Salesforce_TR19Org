public class DMLOperations
{
    List<Lead> listOfLeadRecord = new List<Lead>();
    List<Log__c> errorList = new List<Log__c>();
    boolean flag = true;
        public void insertRecords(){
        //inserting Lead records to the list
        for(Integer i = 1; i<5; i++){
            Lead leadObj = new Lead(LastName='Ramdaf '+i);
            listOfLeadRecord.add(leadObj);
        }

        //store the returned result from Database
        Database.SaveResult[] srList = Database.insert(listOfLeadRecord,false);
        //iterate through the saved result in database
        for(Database.SaveResult sr : srList)
        {
                //executes if operation is succesful
                if(sr.isSuccess())
                    {
                    	System.debug('Record insreted successfully ');

                    }else
                {

                    //this loop executes if operation fails
                    //iterartes over the errors encountered by database
                    //for(Database.Error err : sr.getErrors())
                        Log__c logObj = new Log__c(Error__c='Req Field');
                		errorList.add(logObj);
                		flag = false;
                }
        }
        if(flag == false){
        	insert errorList;
        }
    }

    public void deleteAccount()
    {
		Account[] inactiveAccount = [SELECT Id FROM Account WHERE CreatedDate = LAST_90_DAYS];
		DELETE inactiveAccount;
		System.debug('inactive accounts deleted');
    }
   }