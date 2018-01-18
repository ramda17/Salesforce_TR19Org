public class OpportunityTriggerHandler
{
    public void cloneRecords()
    {
            List<Account> listAccountRecord = new List<Account>();  //list of Account records
            Set<Id> AccountIdSet = new Set<Id>();
            
           //List of names only present in Account 
            List<Account> accountName = [SELECT Name FROM Account];
            
            //Create set for the names
            Set<String> accountNameSet = new Set<String>(); 
            
            for(Account ac : accountName)
            {
                accountNameSet.add(ac.Name);
            }
            
            
            
            for(Account accRecords : [SELECT Id, Name, AccountNumber,BillingStreet, BillingCity,BillingState, BillingCountry FROM Account WHERE Id IN :AccountIdSet])
            {
                    
                    if(accountNameSet.contains(accRecords.Name)){
                    Account accObj = new Account(Id = accRecords.Id);
                    accObj.BillingStreet = accRecords.BillingStreet;
                    accObj.BillingCity = accRecords.BillingCity;
                    accObj.BillingState = accRecords.BillingState;
                    accObj.BillingCountry = accRecords.BillingCountry;
                   
                  }
            }     
      }
}