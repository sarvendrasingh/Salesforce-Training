@isTest
public with sharing class AccountProcessorTest {
  @IsTest
  private static void testSendSms() {
    Account testaccount = new Account(Name = 'Test AccountProcessor account');
    insert testaccount;

    Contact newContact1 = new Contact(
      FirstName = 'Sarvendra',
      LastName = 'Singh',
      AccountId = testaccount.Id
    );
    insert newContact1;
    Contact newContact2 = new Contact(
      FirstName = 'Sanal',
      LastName = 'Mishra',
      AccountId = testaccount.Id
    );
    insert newContact2;

    List<Id> accountId = new List<Id>();
    accountId.add(testaccount.Id);

    Test.startTest();
    AccountProcessor.countContacts(accountId);
    Test.stopTest();
    // runs callout and check results
  }
}
