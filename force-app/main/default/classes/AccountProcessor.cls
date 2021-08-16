public with sharing class AccountProcessor {
  @future
  public static void countContacts(List<Id> accountIds) {
    List<Account> accountsToUpdate = new List<Account>();
    List<Account> accounts = [
      SELECT Id, Name, (SELECT id FROM Contacts)
      FROM Account
      WHERE Id IN :accountIds
    ];
    // process account records to do awesome stuff
    for (Account acc : accounts) {
      List<Contact> contactList = acc.Contacts;
      acc.Number_Of_Contacts__c = contactList.size();
      accountsToUpdate.add(acc);
    }
    update accountsToUpdate;
  }
}
