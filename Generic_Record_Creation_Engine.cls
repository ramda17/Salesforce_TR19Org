global class Generic_Record_Creation_Engine implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT JSON__c, Object_Name__c FROM Event__c');
        // collect the batches of records or objects to be passed to execute
    }

    global void execute(Database.BatchableContext bc, List<Event__c> records){
            List<String> listOfJSONElements_toDeserialize = new List<String>();
            Map<String, Object> newSObjMap = new Map<String, Object>();
            List<SObject> newSobjRecordList = new List<SObject>();
            SObject newSObj;

            for(Event__c eventObj : records){
                System.debug(eventObj.JSON__c);
                newSObjMap = (Map<String, Object>) JSON.deserializeUntyped(eventObj.JSON__c);

                //Create a new sObject
                newSObj = Schema.getGlobalDescribe().get(eventObj.Object_Name__c).newSobject();
                System.debug('created a new Sobject of type==='+ newSObj.getSobjectType());

                for(String key : newSObjMap.keySet()){
                    System.debug(' key :'+ key +' map value===='+ newSObjMap.get(key));
                    newSObj.put(key, newSObjMap.get(key));
                }
                newSobjRecordList.add(newSObj);
            }
            try{
                insert newSobjRecordList;
            } catch(Exception e){
                System.debug('..rd.===Insertion exception'+e.getMessage()); //Before Insert or Upsert list must not have two identically equal elements
                }
            System.debug('records present in the list:'+newSobjRecordList);
    }
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }

}