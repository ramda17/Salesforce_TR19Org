@isTest
public class Duplicate_Leads_Removal_TestClass {
		@isTest
		public static void removeDuplicateLeads_TestMethod(){
			Test_Data_Factory.insertLeads();
			System.debug('..rd..the inserted records ');
			Test.startTest();
				DuplicateLeadsRemoval dlr = new DuplicateLeadsRemoval();
				Id batchId = Database.executeBatch(dlr);
			Test.stopTest();
			System.debug('..rd..working');
			Integer Size = [SELECT COUNT() FROM Lead WHERE LastName='Dafe' AND Email='ram.dafe@gmail.com'];
			System.debug(Size);
			System.assertEquals(1,Size);
		}

		@isTest
		public static void removeMultiDuplicateLeads_TestMethod(){
			Test_Data_Factory.insertLeads();
			Test.startTest();
				DuplicateLeadsRemoval dlr = new DuplicateLeadsRemoval();
				Id batchId = Database.executeBatch(dlr);
			Test.stopTest();
			System.debug('..rd..working');
			Integer Size = 	[
								SELECT 	COUNT()
								FROM 	Lead
								WHERE 	(LastName='Dafe' AND Email='ram.dafe@gmail.com')
								OR 	(LastName='Sengar' AND Email='shweta.sengar@gmail.com')
						 	];
			System.debug(Size);
			System.assertEquals(2,Size);

		}
}