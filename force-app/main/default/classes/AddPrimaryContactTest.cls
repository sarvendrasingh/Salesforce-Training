@isTest
public class AddPrimaryContactTest {
  @testSetup
  static void setup() {
    List<Account> accounts = new List<Account>();
    // add 50 accounts of NY
    for (Integer i = 0; i < 50; i++) {
      accounts.add(new Account(name = 'Test Account' + i, BillingState = 'NY'));
    }
    // add 50 accounts of CA
    for (Integer j = 0; j < 50; j++) {
      accounts.add(new Account(name = 'Test Account' + j, BillingState = 'CA'));
    }
    insert accounts;

    // Contact testContact = new Contact(FirstName = 'Steve', LastName = 'Smith');
    // insert testContact;
  }
  static testMethod void testQueueable() {
    Contact testContact = new Contact(FirstName = 'Steve', LastName = 'Smith');
    insert testContact;
    // Create our Queueable instance
    String state = 'CA';
    AddPrimaryContact primaryContactAddition = new AddPrimaryContact(
      testContact,
      state
    );
    // startTest/stopTest block to force async processes to run
    Test.startTest();
    System.enqueueJob(primaryContactAddition);
    Test.stopTest();
    // Validate the job ran. Check if record have correct parentId now
    System.assertEquals(
      50,
      [
        SELECT COUNT()
        FROM Contact
        WHERE AccountId IN (SELECT Id FROM Account WHERE BillingState = 'CA')
      ]
    );
  }
}
