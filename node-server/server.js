const express = require('express');
const dotenv = require('dotenv').config({path:'../.env'});
const app = express();
// Load Clarifai 
var Clarifai = require('clarifai');

// instantiate a new Clarifai app passing in your clientId and clientSecret
var clarifai = new Clarifai.App(
  process.env.CLARIFY_CLIENT_ID,
  process.env.CLARIFY_SECRET
);

// predict the contents of an image by passing in a url
function predictImageByUrl(url,callback) {
  clarifai.models.predict(Clarifai.GENERAL_MODEL, url).then(callback,callback);
}

app.get("/api",(req,res) => {
  if (req.query.imageUrl) {
    // res.send(req.query.imageUrl);
    let output = {}
    predictImageByUrl(req.query.imageUrl,(response) => {
      res.status(200);
      response.outputs[0].data.concepts.forEach((el) => {
        output[el.name] =  el.value;
      })
      res.json(output);
    },(response,err) => {
      res.status(400).json(err);
    })
  }
})

app.listen(3001,() => {
  console.log("Server listening on port 3001");
})
