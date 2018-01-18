@RestResource(urlMapping='/Leads/*')
global with sharing class Lead_Manipulator_REST_Service  {

    @HttpGet
    global static Lead showRecords() {
        Lead leadRec = [SELECT Id,FirstName,LastName from Lead LIMIT 1];
        return leadRec;
        RestRequest req = RestContext.request;
        String leadId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        System.debug('..ramda..'+req.requestURI);
        Lead leadObj = [
                           SELECT   FirstName
                                ,   LastName
                                ,   Email
                                ,   Phone
                                ,   Company
                             FROM   Lead WHERE Id =: leadId
                      ];
        return leadObj;
    }

    @HttpPost

    global static void create(String firstName, String lastName, String email, String phone, String company) {
        List<Wrapper> wrapperObjectsList = new List<Wrapper>();
        Wrapper wrappedObject = new Wrapper();
        Lead leadObj = new Lead();
        leadObj.FirstName = firstName;
        leadObj.LastName = lastName;
        leadObj.Email = email;
        leadObj.Phone = phone;
        leadObj.Company = company;
        System.debug('....Webservices are working....');
        System.debug('..rd..firstName:'+ firstName);
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        Blob reqBody = req.requestBody;
        System.debug('..rd..====request as fetched from the consumer '+JSON.serialize(reqBody));
        
        System.debug('..rd..====request resource path '+req.resourcePath);
        
        try{
            Database.SaveResult insertionResult = Database.insert(leadObj,false);
                if(insertionResult.isSuccess()){
                    wrappedObject.status = 'Successful';
                    wrappedObject.isSuccess = 'true';
                    wrappedObject.leadRecord = leadObj;
                    wrappedObject.leadId = leadObj.Id;
                } else{
                    wrappedObject.status = String.valueOf(insertionResult.getErrors());
                    wrappedObject.isSuccess = 'false';
                    wrappedObject.leadId = '';
                }
                
            
            //System.debug('.rd.====inside provider req body'+ req.requestBody);    
            //wrappedObject = (Wrapper)JSON.deserialize(JSON.serialize(req.requestBody),Wrapper.class);
            
            res.addHeader('Content-Type', 'application/json');
            res.responseBody = Blob.valueOf(JSON.serialize(wrappedObject));

        }
        catch(Exception ex){
            System.debug('..rd..Exception occured: '+ex.getMessage());
        }


    }

    @HttpPut
    global static void updateleadObject(String firstName, String lastName,String newPhone,String company, String newCompany) {
        
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        //String lead_Id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        //System.debug('Id======>'+lead_Id);
        Lead leadUpdate = [SELECT Id
                                , Company
                                , Phone
                             FROM Lead 
                            WHERE FirstName =: firstName
                             
                              
                          ];
        leadUpdate.Company = newCompany;
        leadUpdate.Phone = newPhone;
        Database.SaveResult saveResults = Database.update(leadUpdate, false);
        Wrapper wrapperObj = new Wrapper();
        if(saveResults.isSuccess()) {
            wrapperObj.isSuccess = 'true';
            wrapperObj.leadID    = saveResults.getId();
            wrapperObj.Status    = 'Success';
            //return wrapperObj;
        } else {
            wrapperObj.isSuccess = 'false';
            wrapperObj.leadID    = '';
            wrapperObj.Status    = String.valueOf(saveResults.getErrors());
            //return wrapperObj;
        }

    }

    @HttpDelete
    global static void remove() {
        System.debug('Remove method');
        RestRequest req = RestContext.request;
        System.debug('..rd..requestBody==='+JSON.serialize(req.requestBody));
        System.debug('..rd..param..firstName====>'+req.params.get('firstName'));
        
        String firstName = req.params.get('firstName');
        String lastName = req.params.get('lastName');
        String phone = req.params.get('phone');
        String company= req.params.get('company');
        
        Lead leadList = [
            SELECT Id
              FROM Lead
             WHERE FirstName =: firstName
               AND LastName =: lastName
               AND Phone =: phone
               AND Company =: company
          ];
          
        Database.DeleteResult deleteResults = Database.delete(leadList, false);
        Wrapper wrapperObj = new Wrapper();
        if(deleteResults.isSuccess()) {
            wrapperObj.isSuccess = 'true';
            wrapperObj.leadID    = deleteResults.getId();
            wrapperObj.Status    = 'Success';
            //return wrapperObj;
        } else {
            wrapperObj.isSuccess = 'false';
            wrapperObj.leadID    = '';
            wrapperObj.Status    = String.valueOf(deleteResults.getErrors());
          }
        
        // String firstName = RestContext.request.params.get('firstName');
        //System.debug('the first name is..rd..==='+firstName);
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(wrapperObj));
        }
     
 
    public class Wrapper{
        public  String status {get; set;}
        public  Lead leadRecord {get; set;}
        public  String isSuccess {get; set;}
        public  Id leadId {get; set;}
    }
}