public with sharing class ManagerVFController2_TestUtility_Class {
	String validSearchString = 'ram';
	String invalidSearchString1 = 'r';
	String invalidSearchString2 = 'ra';

	// list of account corresponding to the initials as in the variable 'searchString'
	List<Account> acct = [
		SELECT Name
		,        Id
		,        Phone
		FROM     Account
		WHERE    Name
		LIKE:    validSearchString + '%'
		];

    // list of alphabet strip that displays on the Contcat page
	List<String> alphabetStrip = new List<String> {'A','B','C','D','E','F','G','H'
                                                    ,'I','J','K','L','M','N','O','P'
                                                    ,'Q','R','S','T','U','V','W','X'
                                                    ,'Y','Z','ALL'
                                                  };

	// list of contacts
	List<Contact> contacts = [
		 SELECT FirstName
			  , LastName
		   FROM Contact
		  WHERE AccountId != NULL
			AND FirstName != NULL
	 ];
}