public class DeleteStudentsMarkedWithYes implements Schedulable {
  public void execute(SchedulableContext ctx) {
    List<Student__c> deleteStudents = [
      SELECT Id
      FROM Student__c
      WHERE Mark_For_Delete__c = 'Yes'
    ];
    delete deleteStudents;
  }
}
