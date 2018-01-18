public without sharing class QueryBuilder_Controller {

    public String objDescription { get; set; }
    public String selectedObject {get; set;}
    public Map<String, Schema.SObjectType> globalDesc;
    public List<SelectOption> fsOptions {get; set;}
    public List<SelectOption> fnsOptions {get; set;}
    public Set<String> fselected {get; set;}
    public Set<String> fnselected {get; set;}
    public List<String> fieldsList {get; set;}
    public Set<String> fieldsSelected {get; set;}
    public Map<String, Schema.SObjectField> objFields {get;set;}
    public List<String> sFields {get; set;}
    public List<String> rFields {get; set;}


    public QueryBuilder_Controller () {
        fieldsList  = new List<String>();
        fsOptions = new List<SelectOption>();
        fnsOptions = new List<SelectOption>();
        fselected  = new Set<String>();
        fnselected = new Set<String>();
    }

    public List<SelectOption> getObjNames()
    {
        List<Schema.SObjectType> globalDescribeValues = Schema.getGlobalDescribe().Values();
        System.debug('..rd..global desc values===>'+globalDescribeValues);
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--None','--None--'));
        for(Schema.SObjectType sobjectType : globalDescribeValues )
        {
            options.add(new SelectOption(sobjectType.getDescribe().getName(),sobjectType.getDescribe().getName()));
        }
         System.debug('..rd..Selected Object===>'+selectedObject);
        options.sort();
        return options;
    }

    // public void fieldsDetail()
    // {    System.debug('..rd..Selected Object===>'+selectedObject);
    //
    //      Schema.DescribeSObjectResult res = Schema.getGlobalDescribe().get(selectedObject).getDescribe();
    //      System.debug('field description start..rd..===>');
    //      System.debug('..rd..===>'+Schema.getGlobalDescribe().get(selectedObject).getDescribe());
    //      objDescription  = ''+res;
    //      System.debug(objDescription);
    //      System.debug('field description over..rd..===>');
    //      try{
    //          objFields = Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap();
    //          System.debug('..rd..ObjFields: ===>'+objFields);
    //      } catch (Exception e) {
    //          System.debug('..rd..===>'+e.getMessage());
    //      }
    //      fieldsList.addAll(objFields.keySet());
    //      fieldsList.sort();
    //      fnselected.addAll(fieldsList);
    //      showFields();
    // }
    //
    // public void showFields() {
    //     fnsOptions.clear();
    //     for(String s : fnselected) {
    //         SelectOption op = new SelectOption(s,s);
    //         fnsOptions.add(op);
    //     }
    // }
}
