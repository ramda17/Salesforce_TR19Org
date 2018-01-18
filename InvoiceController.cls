public with sharing class InvoiceController {
    public String invoiceComapayName {get; set;}
    public String invoiceAddress {get; set;}
    public String invoiceCity {get; set;}
    public String invoicePhno {get; set;}

    public string billid{get;set;}
    public String billName {get; set;}
    public String billCompany {get; set;}
    public String billSteertAddr {get; set;}
    public String billCity {get; set;}
    public String billphno {get; set;}
    public String billEmail {get; set;}
    public String sourceInput {get; set;}
    public List<Account> BillList {get; set;}
    public string billno {get; set;}
    public void displayBillAddressList(){
          BillList=[
            SELECT Id
                ,  Name
                ,  BillingAddress
                ,  Phone
                ,  BillingCity
             FROM  Account
          ];
      }

      public pagereference redirecttoInvoicePdf(){
          //system.debug('=..rd..'+billid);
          pagereference pg=new pagereference('https://c.ap5.visual.force.com/apex/InvoiceForLineItems');
          pg.getParameters().put('Id',billid);
          return pg;
      }
    public void displayInvoice() {
        invoiceComapayName = Label.Company_Name;
        invoiceAddress = Label.Street_Address;
        invoiceCity = LABEL.Company_City;
        invoicePhno = LABEL.Company_Phone;

        sourceInput=ApexPages.currentPage().getParameters().get('Id');
        System.debug('name of the company:' + invoiceComapayName);

        List<Account> accountSpecificInvoice = [
        SELECT Id
            ,  Name
            ,  BillingStreet
            ,  Phone
            ,  BillingCity
            ,  Email__c
             FROM  Account
         WHERE Id =: sourceInput
         ];

        System.debug('Size of list..rd..===>'+accountSpecificInvoice);
        billName = accountSpecificInvoice[0].Name;
        billSteertAddr = accountSpecificInvoice[0].BillingStreet;
        billCity = accountSpecificInvoice[0].BillingCity;
        billphno = accountSpecificInvoice[0].Phone;
        billEmail = accountSpecificInvoice[0].Email__c;
        System.debug('..rd..Account Specific Invoice Record===>'+accountSpecificInvoice);

    }



}