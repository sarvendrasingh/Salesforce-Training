public class ScheduledMarkForDelete implements Schedulable {
  public void execute(SchedulableContext ctx) {
    DeleteMarked markForDelete = new DeleteMarked();
    database.executeBatch(markForDelete);
  }
  //   public static String sch = '20 30 8 10 2 ? 2021';  //Time for scheduling

  //     global static String scheduleMe() {
  //         ScheduledMarkForDelete SC = new ScheduledMarkForDelete();
  //         return System.schedule('My batch Job', sch, SC);
  //     }

  //     global void execute(SchedulableContext sc) {

  //         DeleteMarked markForDelete = new DeleteMarked();
  //         ID batchprocessid = Database.executeBatch(markForDelete);
  //     }
}
