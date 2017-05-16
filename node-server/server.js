const express = require('express');
const dotenv = require('dotenv').config();
const app = express();
const fs = require('fs');
const bodyParser = require('body-parser');

const PORT = process.env.PORT || 3001;
var csv = require("fast-csv");
// Load Clarifai
var Clarifai = require('clarifai');
const ACCESS_CONTROL_ALLOW_ORIGIN_URL = process.env.ACCESS_CONTROL_ALLOW_ORIGIN || 'http://localhost:3000';


// Middleware to allow CORS requests
app.use(function (req, res, next) {
  // Website you wish to allow to connect
  // res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3000');
  res.setHeader('Access-Control-Allow-Origin', ACCESS_CONTROL_ALLOW_ORIGIN_URL);
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
  res.setHeader('Access-Control-Allow-Credentials', true);
  next();

});

app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

// instantiate a new Clarifai app passing in your clientId and clientSecret
var clarifai = new Clarifai.App(
  process.env.CLARIFY_CLIENT_ID,
  process.env.CLARIFY_SECRET
);

// predict the contents of an image by passing in a url
function predictImageByUrl(image64, cbOk, cbErr) {
  //var imageUrl = "http://www.homedepot.com/catalog/productImages/1000/a6/a619a055-6979-4b47-b0da-5dfa09d6ca2b_1000.jpg"
  //clarifai.models.predict(Clarifai.GENERAL_MODEL, imageUrl).then(cbOk,cbErr);
  console.log('Predicting image64...');
  clarifai.models.predict(Clarifai.GENERAL_MODEL, {base64: image64}).then(cbOk, cbErr);
}

app.get('/', (req, res)=>{
  res.send("Hello World");
});

app.post('/api', (req, res) => {
  let image64 = req.body.image;
  image64 = image64.replace(/^"(.*)"$/, '$1');
  predictImageByUrl(image64, function (result) {
    console.log('Processing results from Clarifai API..')
    var suggestions = [];
    result.outputs[0].data.concepts.forEach((value) => {
      suggestions.push(value.name);
    });

    var matchingSuggests = [];
    readDictionary((dictionary) => {

      suggestions.forEach((suggestion) => { // Goes through every suggestion from Clarifai
        let regexp = new RegExp(suggestion, "g");

        dictionary.forEach((dictionaryWord) => { //Tries to match with the dictionary words and add to matchingSuggests array
          if (regexp.test(dictionaryWord)) {
            matchingSuggests.push(dictionaryWord);
          }
        })
      })
      if (matchingSuggests.length > 0) {
        res.send(matchingSuggests);
      } else {
        res.send("Empty response");
      }
    })
  }, function (err) {
    console.log('There was an error fetching data from Clarifai:', err.statusText);

    res.send(err);
  });
})

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);

})


function readDictionary(callback) {
  let dictionary = []
  csv
    .fromPath("tools_dictionary.csv")
    .on("data", function (data) {
      dictionary.push(data[0]);
    })
    .on("end", function () {
      callback(dictionary);
    });
}

