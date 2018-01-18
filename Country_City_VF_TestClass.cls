@isTest ()
public with sharing class Country_City_VF_TestClass {
		@isTest
		/*
			test method for checking whether the dependency between country and city picklist is valid
		*/
		public static void method_To_Check_ValidDependency(){

				Test_Data_Factory.createCustomCountryObj();
				Test_Data_Factory.createCustomCityObj();

				Country_City_VFController ccvf = new Country_City_VFController();
				String country = 'Country1';
				List<SelectOption> countryList = Test_Data_Factory.getCountryList();
				ccvf.countrySelectList = countryList;
				ccvf.country = country;
				//List<SelectOption> citySelectList = Test_Data_Factory.getCityList();
				//List<SelectOption> citySelectList = new List<SelectOption>();
				//ccvf.citySelectList = citySelectList;

				Test.startTest();
						List<SelectOption> options = ccvf.getCitySelectList();
						System.debug(options.size());
				Test.stopTest();

				System.assertEquals(1,options.size());
		}
}