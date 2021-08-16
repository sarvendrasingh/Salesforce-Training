({
  doInit: function (component, event, helper) {
    let action = component.get("c.getItems");
    action.setCallback(this, function (response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        component.set("v.items", response.getReturnValue());
      } else {
        console.log("Failed with state: " + state);
      }
    });
    // Send action off to be executed
    $A.enqueueAction(action);
  },

  clickCreateItem: function (component, event, helper) {
    let validItem = component
      .find("campingform")
      .reduce(function (validSoFar, inputCmp) {
        // Displays error messages for invalid fields
        inputCmp.showHelpMessageIfInvalid();
        return validSoFar && inputCmp.get("v.validity").valid;
      }, true);
    // If we pass error checking, do some real work
    if (validItem) {
      // Create the new expense
      let newItem = component.get("v.newItem");
      // console.log("Create expense: " + JSON.stringify(newExpense));
      helper.createItem(component, newItem);

      // let theItems = component.get("v.items");

      // // Copy the expense to a new object
      // // THIS IS A DISGUSTING, TEMPORARY HACK
      // let itemToPush = JSON.parse(JSON.stringify(newItem));
      // theItems.push(itemToPush);
      // component.set("v.items", theItems);
      // // console.log(theItems);
    }
  }
});
