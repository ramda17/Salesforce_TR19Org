@isTest
public class Test_Data_Factory {
	//insert leads
	public static void insertLeads(){
		List<Lead> leads = new List<Lead>();
		for(Integer i=0; i<5; i++){
			leads.add(
				new Lead(LastName='Dafe', Email='ram.dafe@gmail.com', Company='myTestCompany')
			);
			leads.add(
				new Lead(LastName='Sengar', Email='shweta.sengar@gmail.com', Company='mySecondTestCompany')
			);
		}
		System.debug('..rd..inserted Records are'+leads);
		insert leads;
	}

	//Create a custom country object
	public static void createCustomCountryObj(){
		List<Country__c> countries = new List<Country__c>();
		for(Integer i=0; i<4; i++){
			Country__c countryObj = new Country__c();
			countryObj.Name='Country'+i;
			countries.add(countryObj);
		}
		System.debug('perform insertion of country reco' + countries);
		try{
			insert countries;
		} catch(Exception e){
			System.debug('insretion failed');
		}
	}

	//create a custom city object
	public static void createCustomCityObj(){
		List<City__c> cities = new List<City__c>();
		for(Integer i=0; i<4; i++){
			City__c ctObj = new City__c();
			ctObj.Name='City'+i;
			ctObj.Country__c='Country'+i;
			cities.add(ctObj);
		}

		System.debug('perform insertion of city reco'+cities);
		try{
			insert cities;
		} catch(Exception e){
			System.debug('insertion failed');
			}
	}

	//get city list
	public static List<SelectOption> getCityList(){
		List<SelectOption> listCity = new List<SelectOption>();
		for(Integer i=0; i<4; i++){
			listCity.add(
								new SelectOption('City'+i,'City'+i)
							);
		}
		return listCity;
	}

	//get country list
	public static List<SelectOption> getCountryList(){
		List<SelectOption> listCountry = new List<SelectOption>();
		for(Integer i=0; i<4; i++){
			listCountry.add(
								new SelectOption('Country'+i,'Country'+i)
							);
		}
		return listCountry;
	}

	//insert the Student Records
	public static List<Student__c> insertStudentRecords(){
		List<Student__c> studentList = new List<Student__c>();

		for(Integer i=0; i<10; i++){
			Student__c studObj = new Student__c(Name='ram'+i, Skills__c='HR', City__c='City'+i);
			studentList.add(studObj);
		}
		System.debug('stud list:'+studentList);
		insert studentList;
		return studentList;
	}

	//get a  list of language
	public static List<SelectOption> getLanguageList(){
		List<SelectOption> languageList = new List<SelectOption>();
		for(Integer i=0; i<4; i++){
			languageList.add(
				new SelectOption(i+'Lang', i+'Lang')
			);
		}
		return languageList;
	}

}