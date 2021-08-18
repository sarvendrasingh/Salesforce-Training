public class deleteMarked implements Database.Batchable<sObject>, Database.Stateful {
  public Database.QueryLocator start(Database.BatchableContext bc) {
    Date myDate = Date.today().addDays(-2);
    return Database.getQueryLocator(
      'SELECT ID,Name from Student__c where Is_Registration_Completed__c = false and CreatedDate <= :myDate  ' //:myDate or myDate
    );
  }
  public void execute(Database.BatchableContext bc, List<Student__c> scope) {
    // List<Student__c> studentToUpdate = new List<Student__c>();
    for (Student__c stu : scope) {
      stu.Mark_For_Delete__c = 'Yes';
      //   studentToUpdate.add(stu);
    }
    // update studentToUpdate;
    update scope;
  }
  public void finish(Database.BatchableContext bc) {
    AsyncApexJob job = [
      SELECT
        Id,
        Status,
        NumberOfErrors,
        JobItemsProcessed,
        TotalJobItems,
        CreatedBy.Email
      FROM AsyncApexJob
      WHERE Id = :bc.getJobId()
    ];

    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    String[] toAddresses = new List<String>{ job.CreatedBy.Email };
    mail.setToAddresses(toAddresses);
    mail.setSubject('Mark for delete updated');
    mail.setPlainTextBody(
      'No of students marked for deletion : ' +
      job.TotalJobItems +
      'with ' +
      job.NumberOfErrors +
      ' failures.'
    );
    Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ mail });
  }
}
