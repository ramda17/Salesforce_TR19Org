@isTest
public with sharing class Student_Reg_Form_TestClass {
	@isTest
	//Method to test if records are successfully inserted or not
	public static void insertionTestforStudentRecords(){

			Test.startTest();
			//set the current student registration page
			Test.setCurrentPage(Page.Student_Reg_Form);

			//Create a reference for ApexPage.StandardController
			ApexPages.StandardController sc = new ApexPages.StandardController(new Student__c(Name='TestName', Skills__c='HR', City__c='TestCity'));
			System.debug('standard cont: '+sc);
			//pass the ApexPage.StandardController ref in the constructor
			StudenRegistrationForm_Ext studRegObj = new StudenRegistrationForm_Ext(sc);
			studRegObj.insertStudentRecords();
			Test.stopTest();

			List<ApexPages.Message> msgs = ApexPages.getMessages();
			System.debug(msgs);
			boolean hasMessage = false;
			for(ApexPages.Message msg : msgs){
				if(msg.getDetail().contains('successfully submitted')){
					System.debug('..rd..insertion was successful');
					hasMessage = true;
				}
			}

			System.assert(hasMessage);
	}

	 @isTest
	//Method to test if the language translation is working properly or not
	public static void testTranslationOfStud_RegPage(){

		//List<Student__c> studentList = Test_Data_Factory.insertStudentRecords();
		ApexPages.StandardController sc = new ApexPages.StandardController(new Student__c());

		StudenRegistrationForm_Ext studRegObj = new StudenRegistrationForm_Ext(sc);
		List<SelectOption> langList=Test_Data_Factory.getLanguageList();
		studRegObj.languageSelectList = langList;
		studRegObj.lang = '1Lang';
		System.debug('studRegObj.lang: '+studRegObj.lang);
		Test.startTest();

			Test.setCurrentPage(Page.Student_Reg_Form);
			studRegObj.changeLang();

		Test.stopTest();
		boolean gotLangSet = false;
		if(studRegObj.language=='1L'){
			System.debug('language'+studRegObj.language);
			gotLangSet = true;
		}
		System.assert(gotLangSet);
	}

	@isTest
	public static void testforUnsuccesful_Reco_Submission(){
		List<Student__c> studentList = Test_Data_Factory.insertStudentRecords();

		Test.startTest();
		Test.setCurrentPage(Page.Student_Reg_Form);
		ApexPages.StandardController sc = new ApexPages.StandardController(studentList[0]);
		StudenRegistrationForm_Ext studObj = new StudenRegistrationForm_Ext(sc);
		studObj.insertStudentRecords();
		Test.stopTest();

		List<ApexPages.Message> msgs = ApexPages.getMessages();
		boolean hasMessage = false;

		for(ApexPages.Message msg : msgs){
			System.debug('hello:'+msg);
			if(msg.getDetail().contains(StudenRegistrationForm_Ext.exceptionMessage)){
				hasMessage = true;
			}
		}

		System.assert(hasMessage);
	}
}