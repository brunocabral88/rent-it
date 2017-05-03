var csv = require("fast-csv");

function readDictionary(callback) {
  let dictionary = []
  csv
  .fromPath("tools_dictionary.csv")
  .on("data", function(data){
      dictionary.push(data[0]);
  })
  .on("end", function(){
      callback(dictionary);
  });
}

readDictionary(function(dictionary) {
  matching = [];
  dictionary.forEach((word) => {
    let regexp = new RegExp(word,"g");
    if (regexp.test("hammer")) {

    }
  })
})