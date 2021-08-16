({
  packItem: function (component, event, helper) {
    let itemVar = component.get("v.item");
    itemVar.Packed__c = true;
    component.set("v.item", itemVar);
    event.getSource().set("v.disabled", true);
  }
});
