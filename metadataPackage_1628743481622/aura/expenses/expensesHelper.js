// ({
//   createExpense: function (component, expense) {
//     let theExpenses = component.get("v.expenses");
//     // Copy the expense to a new object
//     // THIS IS A DISGUSTING, TEMPORARY HACK
//     let newExpense = JSON.parse(JSON.stringify(expense));
//     theExpenses.push(newExpense);
//     component.set("v.expenses", theExpenses);
//   }
// });
({
  // createExpense: function (component, expense) {
  //   let action = component.get("c.saveExpense");
  //   action.setParams({
  //     expense: expense
  //   });
  //   action.setCallback(this, function (response) {
  //     let state = response.getState();
  //     if (state === "SUCCESS") {
  //       let expenses = component.get("v.expenses");
  //       expenses.push(response.getReturnValue());
  //       component.set("v.expenses", expenses);
  //     }
  //   });
  //   $A.enqueueAction(action);
  // },
  // updateExpense: function (component, expense) {
  //   let action = component.get("c.saveExpense");
  //   action.setParams({
  //     expense: expense
  //   });
  //   action.setCallback(this, function (response) {
  //     let state = response.getState();
  //     if (state === "SUCCESS") {
  //       // do nothing!
  //     }
  //   });
  //   $A.enqueueAction(action);
  // },
  // saveExpense: function (component, expense, callback) {
  //   let action = component.get("c.saveExpense");
  //   action.setParams({
  //     expense: expense
  //   });
  //   if (callback) {
  //     action.setCallback(this, callback);
  //   }
  //   $A.enqueueAction(action);
  // }
  saveExpense: function (component, expense, callback) {
    let action = component.get("c.saveExpense");
    action.setParams({
      expense: expense
    });
    if (callback) {
      action.setCallback(this, callback);
    }
    $A.enqueueAction(action);
  },
  createExpense: function (component, expense) {
    this.saveExpense(component, expense, function (response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        let expenses = component.get("v.expenses");
        expenses.push(response.getReturnValue());
        component.set("v.expenses", expenses);
      }
    });
  },
  updateExpense: function (component, expense) {
    this.saveExpense(component, expense);
  }
});
