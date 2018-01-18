public class ContactRecords
{
	//following method finds the associated contacts of an Account
	public void findAssociatedContacts(Account accountContacts)
	{
		System.debug(accountContacts.Name);
	}
		
}

// Account acc = [SELECT Contacts FROM Account];
// ContactRecords obj = new ContactRecords();

// for(Account a : acc)
// {
// 		if(a.Name == 'Ram'){
//			obj.findAssociatedContacts(a); break;
// 		}
//	}