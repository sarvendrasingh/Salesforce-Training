({
  convertArrayOfObjectsToCSV: function (component, objectRecords) {
    // declare variables
    let csvStringResult, counter, keys, columnDivider, lineDivider;

    // check if "objectRecords" parameter is null, then return from function
    if (objectRecords == null || !objectRecords.length) {
      return null;
    }
    // store ,[comma] in columnDivider variabel for sparate CSV values and
    // for start next line use '\n' [new line] in lineDivider varaible
    columnDivider = ",";
    lineDivider = "\n";
    keys = ["Custom Objects Selected"];

    csvStringResult = "";
    csvStringResult += keys.join(columnDivider);
    csvStringResult += lineDivider;

    for (let i = 0; i < objectRecords.length; i++) {
      counter = 0;

      for (let sTempkey in keys) {
        let skey = keys[sTempkey];

        // add , [comma] after every String value,. [except first]
        if (counter > 0) {
          csvStringResult += columnDivider;
        }

        csvStringResult += '"' + objectRecords[i] + '"';

        counter++;
      } // inner for loop close
      csvStringResult += lineDivider;
    } // outer main for loop close

    // return the CSV formate String
    return csvStringResult;
  }
});
