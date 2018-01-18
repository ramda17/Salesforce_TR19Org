public with sharing class Country_City_VFController {

     public String country          {get; set;}
     public String city            {get; set;}

      //Provide a complete select list for countries on the page
     public List<selectOption> countrySelectList {
        get {
            List<selectOption> options = new List<selectOption>();
            options.add(new SelectOption('-select-','-select-'));
            for (Country__c coun : Country__c.getAll().values()){
                options.add(new SelectOption(coun.Name,coun.Name));
            }
               return options;
        }
        set;
      }



      public List<selectOption> getCitySelectList() {
          //System.debug('..rd..getCitySelectList method is running');
          List<selectOption> citySelectList = new List<selectOption>();
          List<selectOption> options = new List<selectOption>();
          for(City__c ct : City__c.getAll().values()) {
              //System.debug('..rd.. for_loop of getCitySelectList' + ct);
              //System.debug('Country '+country);
              if(ct.Country__c == this.country){
                  options.add(new SelectOption(ct.Name,ct.Name));
                  System.debug('ct.Name:'+ct.Name);
               }
           }
           return options;
       }
   }