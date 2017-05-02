const express = require('express');
const dotenv = require('dotenv').config({path:'../.env'});
const app = express();
const fs = require('fs');
// Load Clarifai
var Clarifai = require('clarifai');

// instantiate a new Clarifai app passing in your clientId and clientSecret
var clarifai = new Clarifai.App(
  process.env.CLARIFY_CLIENT_ID,
  process.env.CLARIFY_SECRET
);

// predict the contents of an image by passing in a url
function predictImageByUrl(imageUrl,cbOk,cbErr) {
  clarifai.models.predict(Clarifai.GENERAL_MODEL, imageUrl).then(cbOk,cbErr);
}

app.get("/api",(req,res) => {
  if (req.query.imageUrl) {
    var output = {};
    console.log("Trying to predict: ",req.query.imageUrl);
    predictImageByUrl(req.query.imageUrl.toString(),(response) => {
      res.status(200);
      response.outputs[0].data.concepts.forEach((el) => {
        output[el.name] = el.value;
      })
      res.send(output);
    },(err) => {
      res.send(err);
    })
  } else {
    res.send("Please specify a url using the ?imageUrl variable");
  }
})

app.listen(3001,() => {
  console.log("Server listening on port 3001");
})
