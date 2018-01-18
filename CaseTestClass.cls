@isTest
public class CaseTestClass{
    static testMethod void testCaseHandler(){
        List<EFT_Transaction_Status__c> listEFT = new List<EFT_Transaction_Status__c>();
        for(Integer i=0; i<200; i++){
          EFT_Transaction_Status__c eft = new EFT_Transaction_Status__c(
                                                                        Method_Name__c='Credit Card Address Verification'
                                                                        , Transaction_Status__c = 'Declined'
                                                                        , Sales_Header__c = 'Item-0001'
                                                                        );
            listEFT.add(eft);
      }
      System.debug(Limits.getLimitQueries());
          test.startTest();
          insert listEFT;
          System.debug(Limits.getLimitQueries());
          test.stopTest();
          System.debug(Limits.getLimitQueries());
          }
}