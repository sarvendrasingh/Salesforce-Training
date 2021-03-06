({
  init: function (component, event, helper) {
    let action = component.get("c.getObjectName");
    action.setCallback(this, function (response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        let allValues = response.getReturnValue();
        component.set("v.options", allValues);
      }
    });
    $A.enqueueAction(action);
  },

  handleSelection: function (component, event, helper) {
    // rerender
    helper.rerender(component);

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
    // error handling (rerender)
    component.set("v.sObjects", []);
    component.set("v.fieldsSelected", false);
    if (component.get("v.selectedFields").length == 0) {
      let queryText = "";
      component.set("v.queryBoxText", queryText);
    } else {
      //main content starts here
      let selectedOption = component.find("dropdown").get("v.value");
      let queryText = "SELECT ";
      let selectedValues = helper.getSelectedFields(component);
      for (let i = 0; i < selectedValues.length; i++) {
        if (i == selectedValues.length - 1) {
          queryText += selectedValues[i];
          break;
        }
        queryText += selectedValues[i] + ", ";
      }
      queryText += " FROM " + selectedOption;
      component.set("v.queryBoxText", queryText);
    }
  },
  getQueryResult: function (component, event, helper) {
    let query = component.get("v.queryBoxText");
    let selectedValues = helper.getSelectedFields(component);
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
        component.set("v.fieldsSelected", true);
      }
    });
    $A.enqueueAction(action);
  }
});
