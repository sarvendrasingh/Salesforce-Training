({
  init: function (component, event, helper) {
    let action = component.get("c.getCustomObjects");
    action.setCallback(this, function (response) {
      let state = response.getState();
      if (state === "SUCCESS") {
        let customFields = response.getReturnValue();
        let fieldMap = [];
        for (let i = 0; i < customFields.length; i++) {
          fieldMap.push({ label: customFields[i], value: customFields[i] });
        }
        component.set("v.dualOptions", fieldMap);
      }
    });
    $A.enqueueAction(action);
  },

  downloadFile: function (component, event, helper) {
    let objectsData = component.get("v.selectedObjects");
    let csv = helper.convertArrayOfObjectsToCSV(component, objectsData);
    // console.log(component.get("v.selectedObjects"));
    if (csv == null) {
      return;
    }
    // console.log(csv);

    // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####
    var hiddenElement = document.createElement("a");
    hiddenElement.href = "data:text/csv;charset=utf-8," + encodeURI(csv);
    hiddenElement.target = "_self"; //
    hiddenElement.download = "ExportData.csv"; // CSV file Name* you can change it.[only name not .csv]
    document.body.appendChild(hiddenElement); // Required for FireFox browser
    hiddenElement.click(); // using click() js function to download csv file
  }
});
