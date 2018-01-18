global class Lead_Manipulator_SOAP_Service  {

    //webservice method for creatiing record
    webservice static String create(String firstName, String lastName, String email, String phone, String company) {
        Wrapper wrappedObject = new Wrapper();
        Lead leadObj = new Lead();
        leadObj.FirstName = firstName;
        leadObj.LastName = lastName;
        leadObj.Email = email;
        leadObj.Phone = phone;
        leadObj.Company = company;
        System.debug('....==>Webservices are working....');
        System.debug('..rd..==>firstName:'+ firstName);
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
        }
        catch(Exception ex){
            System.debug('..rd..===>Exception occured: '+ex.getMessage());
        }
        return (String)JSON.serialize(wrappedObject);
    }

    //method for updating record
    webservice static String updateleadObject(String firstName, String lastName,String newPhone,String company, String newCompany) {


        //String lead_Id = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        //System.debug('Id======>'+lead_Id);
        Lead leadUpdate = [SELECT Id
                                , Company
                                , Phone
                             FROM Lead
                            WHERE FirstName =: firstName
                              AND LastName =: lastName
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
            wrapperObj.status    = String.valueOf(saveResults.getErrors());
            //return wrapperObj;
        }
        return (String)JSON.serialize(wrapperObj);

    }


    //method for deleteiing record
    webservice static String remove(String firstName, String lastName, String email, String phone, String company ) {
        System.debug('Remove method');
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
            wrapperObj.status    = String.valueOf(deleteResults.getErrors());
          }
        return (String)JSON.serialize(wrapperObj);
        }



    global class Wrapper {
        webservice  String status {get; set;}
        webservice  Lead leadRecord {get; set;}
        webservice  String isSuccess {get; set;}
        webservice  Id leadId {get; set;}
    }

 }