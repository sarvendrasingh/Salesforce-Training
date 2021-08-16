global class DailyLeadProcessor implements Schedulable {
  global void execute(SchedulableContext ctx) {
    List<Lead> leadToUpdate = new List<Lead>();
    List<Lead> leads = [SELECT Id FROM Lead WHERE LeadSource = NULL LIMIT 200];
    for (Lead l : leads) {
      l.LeadSource = 'Dreamforce';
      leadToUpdate.add(l);
    }
    update leadToUpdate;
  }
}
