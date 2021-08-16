trigger StudentHistoryTrigger on Student__c(after update) {
  List<Student_History__c> updated = new List<Student_History__c>();

  // Student__c stuObject = new Student__c();
  // Schema.SObjectType objType = stuObject.getSObjectType();
  Map<String, Schema.SObjectField> mapFields = Schema.SObjectType.Student__c.fields.getMap();

  public List<String> AllLabels { get; set; }
  public Mentor__c oldMentor;
  public Mentor__c newMentor;

  for (Student__c stu : Trigger.new) {
    Student__c oldRecord = Trigger.oldMap.get(stu.ID);

    for (String str : mapFields.keyset()) {
      // AllLabels.add(mapFields.get(str).getDescribe().getLabel());

      if (
        (mapFields.get(str).getDescribe().getLabel() != 'System Modstamp') &&
        (mapFields.get(str).getDescribe().getLabel() != 'Last Modified Date')
      ) {
        Student_History__c stuHistory = new Student_History__c();
        String oldValue, newValue;
        if (mapFields.get(str).getDescribe().getLabel() == 'Mentor') {
          oldMentor = [
            SELECT Name
            FROM Mentor__c
            WHERE Mentor__c.id = :String.valueOf(oldRecord.get(str))
          ];
          newMentor = [
            SELECT Name
            FROM Mentor__c
            WHERE Mentor__c.id = :String.valueOf(stu.get(str))
          ];

          oldValue = oldMentor.Name;
          newValue = newMentor.Name;
        } else {
          oldValue = String.valueOf(oldRecord.get(str));
          newValue = String.valueOf(stu.get(str));
        }
        if (oldValue != newValue) {
          stuHistory.Field_Name__C = mapFields.get(str)
            .getDescribe()
            .getLabel();
          stuHistory.Old_Value__c = oldValue;
          stuHistory.New_Value__c = newValue;
          stuHistory.Record_Id__c = String.valueOf(stu.Id);
          updated.add(stuHistory);
        }
      }
    }
  }

  insert updated;
}
