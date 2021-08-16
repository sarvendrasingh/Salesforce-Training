@isTest
private class LeadProcessorTest {
  @testSetup
  static void setup() {
    List<Lead> leads = new List<Lead>();
    // insert 200 leads
    for (Integer i = 0; i < 200; i++) {
      leads.add(new Lead(LastName = 'Lead ' + i, Company = 'Test Company'));
    }
    insert leads;
  }
  @isTest
  static void test() {
    Test.startTest();
    LeadProcessor countLead = new LeadProcessor();
    Id batchId = Database.executeBatch(countLead);
    Test.stopTest();

    // after the testing stops, assert leads were updated properly
    System.assertEquals(
      200,
      [SELECT COUNT() FROM Lead WHERE LeadSource = 'Dreamforce']
    );
  }
}
