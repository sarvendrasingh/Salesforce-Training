public with sharing class GetCustomObjectsController {
  @AuraEnabled
  public static List<String> getCustomObjects() {
    List<String> returnList = new List<String>();
    List<Schema.SObjectType> sObjectList = Schema.getGlobalDescribe().Values();
    for (SObjectType sObjectType : sObjectList) {
      if (sObjectType.getDescribe().getName().right(3) == '__c') {
        returnList.add(sObjectType.getDescribe().getName());
      }
    }
    returnList.sort();
    return returnList;
  }
}
