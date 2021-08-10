({
  init: function (component, event, helper) {
    var action = component.get("c.getObjectName");
    action.setCallback(this, function (response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        var allValues = response.getReturnValue();
        component.set("v.options", allValues);
      }
    });
    $A.enqueueAction(action);
  },
  handleChange: function (component, event) {
    let selectedValues = component.get("v.selectedFields");
  },
  handleSelection: function (component, event) {
    let selectedOption = component.find("dropdown").get("v.value");
    let action = component.get("c.getFields");
    action.setParams({
      sObjectAPIName: selectedOption
    });
    action.setCallback(this, function (response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        let allFieldValues = response.getReturnValue();
        let fieldMap = [];
        for (let i = 0; i < allFieldValues.length; i++) {
          fieldMap.push({ label: allFieldValues[i], value: allFieldValues[i] });
        }
        component.set("v.dualOptions", fieldMap);
      }
    });
    $A.enqueueAction(action);
  },
  getQueryText: function (component, event, helper) {
    let selectedOption = component.find("dropdown").get("v.value");
    let queryText = "SELECT ";
    let selectedValues = component.get("v.selectedFields");
    for (let i = 0; i < selectedValues.length; i++) {
      if (i == selectedValues.length - 1) {
        queryText += selectedValues[i];
        break;
      }
      queryText += selectedValues[i] + ", ";
    }
    queryText += " FROM " + selectedOption;
    component.set("v.queryBoxText", queryText);
  },
  getQueryResult: function (component, event, helper) {
    let query = component.get("v.queryBoxText");
    let selectedValues = component.get("v.selectedFields");
    let action = component.get("c.getQueryResults");
    action.setParams({
      query: query,
      selectedValues: selectedValues
    });
    action.setCallback(this, function (response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        let sObjectList = response.getReturnValue();
        component.set("v.sObjects", sObjectList);
      }
    });
    $A.enqueueAction(action);
  }
});
