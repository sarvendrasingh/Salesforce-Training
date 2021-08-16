({
  getSelectedFields: function (component) {
    return component.get("v.selectedFields");
  },

  rerender: function (component) {
    let queryText = "";
    component.set("v.queryBoxText", queryText);
    component.set("v.selectedFields", []);
    component.set("v.sObjects", []);
    component.set("v.fieldsSelected", false);
  }
});
