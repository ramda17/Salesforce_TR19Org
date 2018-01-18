public class StudenRegistrationForm_Ext{
    public Student__c studentRecord    {get; set;}
    public  String language     {get; set;}
    public String lang          {get; set;}
    public static String successfulSubmission = 'Form has been submtted';
    public static String exceptionMessage;
    ApexPages.standardController sc;

    public StudenRegistrationForm_Ext(ApexPages.standardController sc) {
        this.sc = sc;
        this.studentRecord = (Student__c)sc.getRecord();
        System.debug(sc);
    }

    public void changeLang() {
        language = lang.subString(0,2).toLowerCase();
    }

     public List<selectOption> languageSelectList {
        get {
            List<selectOption> options = new List<selectOption>();
            for (Language__c lg : Language__c.getAll().values()){
                options.add(new SelectOption(lg.Name,lg.Name));
            }
            return options;
        }
        set;
      }

    //Page refernce
    public void insertStudentRecords() {
        System.debug('..rd.. inside insertRec method' + studentRecord);
        try {
            System.debug('...studentRecord: ' + studentRecord);
            insert studentRecord;
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'successfully submitted'));
            //return Page.Student_Reg_Form;
        } catch(Exception ex) {
            exceptionMessage=ex.getMessage();
            ApexPages.AddMessage( new ApexPages.Message(ApexPages.Severity.ERROR, StudenRegistrationForm_Ext.exceptionMessage) );
            System.debug('there was a problem at line 35');
        }
        //return null;
    }

    // public void resetInstance() {
    //     System.debug('...inside reset');
    //     sc.reset();
    //     studentRecord = (Student__c)sc.getRecord();
    // }

}
