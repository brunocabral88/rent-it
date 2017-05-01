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

let img ="";

img = fs.readFileSync('./pic1.jpeg');
// fs.readFileSync('./pic1.jpeg', (err, data) => {
//   if (err) throw err;
//   // console.log(18,data)
//   return img = data;
// });
console.log(21,img)

// function find_img_file(img) {
//   try {
//       let data = fs.readFileSync(img, 'base64');
//       // console.log(data);
//   } catch(e) {
//       console.log('Error:', e.stack);
//   }



//   console.log(30, data)

  function baseencoding(img) {
    return {base64: new Buffer(img).toString('base64')}
  }
  console.log(24,baseencoding(img))


  // predict the contents of an image by passing in a url
  function predictImageByUrl(image,callback) {
    clarifai.models.predict(Clarifai.GENERAL_MODEL,  baseencoding(image)).then(callback,callback);
  }
  app.get("/api",(req,res) => {
    if (req.query.image) {
      // res.send(req.query.image);
      let output = {}
      predictImageByUrl(req.query.image,(response) => {
        console.log(response.data.outputs)
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
