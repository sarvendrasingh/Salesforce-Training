@isTest
private class DailyLeadProcessorTest {
  // Dummy CRON expression: midnight on March 15.
  // Because this is a test, job executes
  // immediately after Test.stopTest().
  public static String CRON_EXP = '0 0 0 15 3 ? 2022';
  static testMethod void testScheduledJob() {
    // Create some out of date Lead records
    List<Lead> leads = new List<Lead>();
    for (Integer i = 0; i < 200; i++) {
      Lead l = new Lead(
        FirstName = 'Lead ' + i,
        LastName = 'Singh',
        Company = 'Ksolves'
      );
      leads.add(l);
    }
    insert leads;

    Test.startTest();
    String jobId = System.schedule(
      'ScheduledApexTest',
      CRON_EXP,
      new DailyLeadProcessor()
    );
    Test.stopTest();

    // Now that the scheduled job has executed,
    // check that our leads were created
    List<Lead> testCreation = new List<Lead>();
    testCreation = [
      SELECT Id
      FROM Lead
      WHERE LeadSource = 'Dreamforce' AND Company = 'Ksolves'
    ];
    System.assertEquals(200, testCreation.size(), 'Leads were not created');
  }
}
