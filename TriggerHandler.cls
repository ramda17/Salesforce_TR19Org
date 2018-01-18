public class TriggerHandler
{
    //Method containing logic, what happens when trigger is fired 
    public static void fireTrigger()
    {
        //Trigger was fired as a result of insert operation
        if(Trigger.isInsert){
        System.debug('Insert Opr');
        List<AITR__c> ls = Trigger.New; 
        System.debug('Trigger.new list form : '+ls);
        System.debug('Trigger.old : '+Trigger.Old);
        System.debug('Trigger.newMap : '+Trigger.NewMap);
        System.debug('Trigger.oldMap : '+Trigger.OldMap);
        }
    
        //Trigger was fired as a result of update operation
        else if(Trigger.isUpdate){
        System.debug('Update opr');
        List<AITR__c> ls = Trigger.New;
        System.debug('Trigger.new : '+ls);
        System.debug('Trigger.old : '+Trigger.Old);
        System.debug('Trigger.newMap : '+Trigger.NewMap);
        System.debug('Trigger.oldMap : '+Trigger.OldMap);
        }
    
        //Trigger gets fired when all records are saved
        else if(Trigger.isDelete){
        System.debug('Del opr');
        System.debug('Trigger.new : '+Trigger.New);
        System.debug('Trigger.old : '+Trigger.Old);
        System.debug('Trigger.newMap : '+Trigger.NewMap);
        System.debug('Trigger.oldMap : '+Trigger.OldMap);
        }
    
        //Trigger gets fired before any record is saved
        else if(Trigger.isBefore){
        System.debug('Before opr');
        System.debug('Trigger.new : '+Trigger.New);
        System.debug('Trigger.old : '+Trigger.Old);
        System.debug('Trigger.newMap : '+Trigger.NewMap);
        System.debug('Trigger.oldMap : '+Trigger.OldMap);
        }
    
    }
}