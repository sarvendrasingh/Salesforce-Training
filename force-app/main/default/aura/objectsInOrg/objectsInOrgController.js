({
  doInit: function (component, event, helper) {
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
  handleChange: function (component, event) {
    // eslint-disable-next-line no-alert
    alert(event.getParam("value"));
  },
  handleSelectField: function (Component, event) {
    // This will contain an array of the "value" attribute of the selected options
    let selectedOptionValue = event.getParam("selectedValue");
    // alert(
    //   "Option selected with value: '" + selectedOptionValue.toString() + "'"
    // );
    let action = component.get("c.getFields");
    action.setCallback(this, function (response) {
      let state = response();
    });
    $A.enqueueAction(action);
  }
});
