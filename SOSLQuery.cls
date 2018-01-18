public class SOSLQuery
{
    public void searchElements()
    {
      List<List<SObject>> searchList = [FIND 'test' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead, User];
      Account[] searchAccounts = (Account[]) searchList[0];
      Contact[] searchContacts = (Contact[]) searchList[1];
      Opportunity[] searchOpportunity = (Opportunity[])searchList[2];
      Lead[] searchLead = (Lead[]) searchList[3];
      User[] searchUser = (User[])searchList[4];
      for(Account  acc : searchAccounts)
      {
          System.debug(acc);
      }

      for(Contact  con : searchContacts)
      {
          System.debug(con);
      }
    }
}